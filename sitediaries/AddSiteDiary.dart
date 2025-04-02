// import 'dart:io';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:sme/app/user/general/sites/SiteController.dart';
// import 'package:sme/utils/appcolor.dart';
// import 'package:sme/utils/appfonts.dart';
// import 'package:sme/utils/appdatabase.dart';
// import 'package:sme/utils/appstring.dart';
// import 'package:sme/utils/apputils.dart';
// import 'package:sme/utils/appwidgets.dart';
// import 'new_sitediaries_logic.dart';
// import 'model/worksModel.dart';
//
// class AddSiteDiary extends StatefulWidget {
//   const AddSiteDiary({super.key, required this.isEdit});
//
//   final bool isEdit;
//
//   @override
//   State<AddSiteDiary> createState() => _AddSiteDiaryState();
// }
//
// class _AddSiteDiaryState extends State<AddSiteDiary> {
//   SiteDiaryController siteDiaryController = Get.put(SiteDiaryController());
//   SiteController siteController = Get.put(SiteController());
//
//   DateTime initialDate = DateTime.now();
//   TextEditingController dowController = TextEditingController();
//   TextEditingController tradeController = TextEditingController();
//   TextEditingController nomController = TextEditingController();
//   TextEditingController hwController = TextEditingController();
//
//   ValueNotifier<int> change = ValueNotifier<int>(0);
//   ValueNotifier<int> dialogChange = ValueNotifier<int>(0);
//
//   String category = '1';
//   List<DropdownMenuItem> dropDownItem = [];
//
//   List<WorksModel> worksList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         body: Stack(
//           children: [
//             AppWidgets.background(),
//             ValueListenableBuilder(
//               valueListenable: change,
//               builder: (context, value, child) {
//                 return Column(
//                   children: [
//                     AppWidgets.commonAppBar(
//                       title: widget.isEdit ? 'Edit SiteDiary' : 'Add SiteDiary',
//                       centerTitle: true,
//                       onBackTap: () {
//                         FocusScope.of(Get.context!).unfocus();
//                         AppUtils().playAudio(audioPlayer: AppWidgets.audioPlayer);
//                         siteDiaryController.singleSiteDiary.clear();
//                         siteDiaryController.selectedImages.clear();
//                         Get.back();
//                       },
//                     ),
//                     AppWidgets.underDevelopment(),
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 5),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width: Get.width * 0.25,
//                                     child: AppWidgets.customText(text: 'Select Date', style: AppFonts.white18),
//                                   ),
//                                   SizedBox(
//                                     width: Get.width * 0.55,
//                                     child: AppWidgets.quoteFields(
//                                       vertical: 0,
//                                       readOnly: true,
//                                       onTap: () async {
//                                         DateTime? selectedDate = await showDatePicker(
//                                           context: context,
//                                           initialDate: initialDate,
//                                           firstDate: initialDate.subtract(const Duration(days: 365)),
//                                           lastDate: initialDate.add(const Duration(days: 365)),
//                                         );
//                                         if (selectedDate != null) {
//                                           initialDate = selectedDate;
//                                         }
//                                         change.value = Random().nextInt(9999999);
//                                       },
//                                       suffixIcon: const Icon(Icons.keyboard_arrow_down, color: AppColors.white, size: 20),
//                                       hintText: '${initialDate.day} - ${initialDate.month} - ${initialDate.year}',
//                                       showCursor: false,
//                                       hintStyle: AppFonts.black18,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             GetX<SiteController>(
//                               builder: (controller) {
//                                 dropDownItem.clear();
//                                 // Check if there are any sites
//                                 if (siteController.sitesList.isEmpty) {
//                                   // Return an empty container or placeholder if no sites
//                                   return const SizedBox();
//                                 }
//
//                                 // Ensure category exists in the sites list
//                                 bool categoryExists = siteController.sitesList.any((site) => site.jobId == category);
//
//                                 if (!categoryExists && siteController.sitesList.isNotEmpty) {
//                                   // Set category to first item's jobId if current category doesn't exist
//                                   category = siteController.sitesList[0].jobId!;
//                                 }
//
//                                 // Create dropdown items
//                                 for (var siteList in siteController.sitesList) {
//                                   dropDownItem.add(
//                                     DropdownMenuItem(
//                                       value: siteList.jobId,
//                                       child: Container(
//                                         width: Get.width * 0.65,
//                                         padding: const EdgeInsets.only(left: 4.0),
//                                         child: AppWidgets.customText(text: '${siteList.jobNo} - ${siteList.projectName}', style: AppFonts.white14, maxLines: 3),
//                                       ),
//                                     ),
//                                   );
//                                 }
//
//                                 return Padding(
//                                   padding: const EdgeInsets.only(bottom: 15, left: 7, right: 7),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(bottom: 10, left: 10),
//                                         child: AppWidgets.customText(text: 'Select\nProject', style: AppFonts.white18),
//                                       ),
//                                       Container(
//                                         color: AppColors.appColor.withValues(alpha: 0.5),
//                                         margin: const EdgeInsets.symmetric(horizontal: 10),
//                                         child: DropdownButton(
//                                             value: category,
//                                             underline: const SizedBox(),
//                                             icon: const Icon(
//                                               Icons.keyboard_arrow_down,
//                                               color: Colors.white,
//                                               size: 20,
//                                             ),
//                                             dropdownColor: AppColors.darkBlue,
//                                             items: dropDownItem,
//                                             onChanged: (itemIdentifier) {
//                                               if (itemIdentifier != null) {
//                                                 category = itemIdentifier;
//                                                 change.value = Random().nextInt(999999);
//                                               }
//                                             }),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: Get.width * 0.29),
//                               child: AppWidgets.addButton(
//                                 onPressed: () {
//                                   tradeController.text = '';
//                                   nomController.text = '';
//                                   hwController.text = '';
//                                   dowController.text = '';
//                                   Get.dialog(
//                                     barrierDismissible: false,
//                                     Dialog(
//                                       child: _addEditWorks(),
//                                     ),
//                                   );
//                                 },
//                                 padding: const EdgeInsets.symmetric(vertical: 5),
//                                 text: 'ADD WORKS',
//                                 addIcon: true,
//                               ),
//                             ),
//                             SizedBox(
//                               height: Get.height * 0.5,
//                               child: worksList.isNotEmpty
//                                   ? ListView.builder(
//                                       physics: const ClampingScrollPhysics(),
//                                       padding: EdgeInsets.zero,
//                                       itemCount: worksList.length,
//                                       itemBuilder: (context, index) {
//                                         return InkWell(
//                                           onTap: () {},
//                                           child: Dismissible(
//                                             key: ValueKey(Random().nextInt(999999)),
//                                             background: Container(
//                                               padding: const EdgeInsets.only(right: 20),
//                                               margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
//                                               alignment: Alignment.centerRight,
//                                               color: AppColors.appColor,
//                                               child: const Icon(
//                                                 Icons.delete,
//                                                 size: 30,
//                                                 color: AppColors.red,
//                                               ),
//                                             ),
//                                             confirmDismiss: (direction) {
//                                               return showDialog(
//                                                 context: context,
//                                                 builder: (ctx) => AlertDialog(
//                                                   title: AppWidgets.customText(
//                                                     text: 'Want to remove??',
//                                                     style: AppFonts.black14,
//                                                   ),
//                                                   actions: [
//                                                     TextButton(
//                                                       onPressed: () {
//                                                         worksList.removeAt(index);
//                                                         Get.back();
//                                                         change.value = Random().nextInt(999999);
//                                                       },
//                                                       child: AppWidgets.customText(
//                                                         text: 'Yes',
//                                                         style: AppFonts.red14,
//                                                       ),
//                                                     ),
//                                                     TextButton(
//                                                       onPressed: () {
//                                                         Get.back();
//                                                       },
//                                                       child: AppWidgets.customText(
//                                                         text: 'No',
//                                                         style: AppFonts.green14,
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                               );
//                                             },
//                                             direction: DismissDirection.endToStart,
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                 color: AppColors.appColor.withValues(alpha: .6),
//                                                 borderRadius: BorderRadius.circular(10),
//                                               ),
//                                               margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                                               child: Column(
//                                                 children: [
//                                                   Container(
//                                                     height: 35,
//                                                     padding: const EdgeInsets.symmetric(horizontal: 5),
//                                                     decoration: const BoxDecoration(
//                                                       color: AppColors.white,
//                                                     ),
//                                                     child: Center(
//                                                       child: AppWidgets.customText(text: worksList[index].trade, style: AppFonts.black20),
//                                                     ),
//                                                   ),
//                                                   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                     children: [
//                                                       Padding(
//                                                         padding: const EdgeInsets.all(8.0),
//                                                         child: Column(
//                                                           children: [
//                                                             AppWidgets.customText(text: 'No. of Men', style: AppFonts.white14.copyWith(fontWeight: FontWeight.bold)),
//                                                             AppWidgets.customText(text: worksList[index].nom.toString(), style: AppFonts.white14),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Padding(
//                                                         padding: const EdgeInsets.all(8.0),
//                                                         child: Column(
//                                                           children: [
//                                                             AppWidgets.customText(text: 'Hours Worked', style: AppFonts.white14.copyWith(fontWeight: FontWeight.bold)),
//                                                             AppWidgets.customText(text: worksList[index].hw.toString(), style: AppFonts.white14),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Padding(
//                                                         padding: const EdgeInsets.all(8.0),
//                                                         child: Column(
//                                                           children: [
//                                                             AppWidgets.customText(text: 'Description of Work', style: AppFonts.white14.copyWith(fontWeight: FontWeight.bold)),
//                                                             AppWidgets.customText(text: worksList[index].desc, style: AppFonts.white14),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     )
//                                   : const SizedBox(),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             InkWell(
//                               onTap: () async {
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return AlertDialog(
//                                       backgroundColor: AppColors.white,
//                                       surfaceTintColor: AppColors.white,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(0),
//                                       ),
//                                       title: AppWidgets.snText(
//                                         text: "Select Image Source",
//                                         style: AppFonts.black16.copyWith(
//                                           fontSize: 16.sp,
//                                         ),
//                                       ),
//                                       content: Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           ListTile(
//                                             contentPadding: const EdgeInsets.all(0),
//                                             leading: const Icon(Iconsax.camera, color: AppColors.lightBlue),
//                                             title: AppWidgets.snText(
//                                               text: "Camera",
//                                               style: AppFonts.black16.copyWith(
//                                                 fontSize: 15.sp,
//                                               ),
//                                             ),
//                                             onTap: () {
//                                               siteDiaryController.pickImages(false);
//                                               siteDiaryController.refreshImagesChange.value = Random().nextInt(9999999);
//                                               Get.back();
//                                             },
//                                           ),
//                                           ListTile(
//                                             contentPadding: const EdgeInsets.all(0),
//                                             leading: const Icon(Iconsax.gallery, color: AppColors.lightBlue),
//                                             title: AppWidgets.snText(
//                                               text: "Gallery",
//                                               style: AppFonts.black16.copyWith(
//                                                 fontSize: 15.sp,
//                                               ),
//                                             ),
//                                             onTap: () {
//                                               siteDiaryController.pickImages(true);
//                                               siteDiaryController.refreshImagesChange.value = Random().nextInt(9999999);
//                                               Get.back();
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                               child: Container(
//                                 width: Get.width * .9,
//                                 decoration: const BoxDecoration(
//                                   color: AppColors.white,
//                                 ),
//                                 padding: const EdgeInsets.all(12),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     AppWidgets.snText(
//                                       text: "Upload Photos",
//                                       style: AppFonts.white16.copyWith(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 15.sp,
//                                         color: AppColors.lightBlue,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 10),
//                                     const Icon(
//                                       Icons.add_a_photo,
//                                       color: AppColors.green,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Obx(() {
//                               return siteDiaryController.selectedImages.isNotEmpty
//                                   ? Container(
//                                       width: Get.width * .9,
//                                       margin: const EdgeInsets.symmetric(horizontal: 8),
//                                       decoration: const BoxDecoration(
//                                         color: AppColors.lightBlue,
//                                       ),
//                                       height: 120,
//                                       child: ValueListenableBuilder(
//                                         valueListenable: siteDiaryController.refreshImagesChange,
//                                         builder: (context, value, child) {
//                                           return ListView.builder(
//                                             shrinkWrap: true,
//                                             scrollDirection: Axis.horizontal,
//                                             itemCount: siteDiaryController.selectedImages.length,
//                                             itemBuilder: (context, index) {
//                                               return Padding(
//                                                 padding: const EdgeInsets.all(8.0),
//                                                 child: InkWell(
//                                                   onTap: () {
//                                                     showDialog(
//                                                       context: context,
//                                                       builder: (context) {
//                                                         return Dialog(
//                                                           child: SizedBox(
//                                                             height: Get.height * 0.6,
//                                                             width: Get.width * 0.9,
//                                                             child: Image.file(
//                                                               File(siteDiaryController.selectedImages[index].path),
//                                                               fit: BoxFit.cover,
//                                                             ),
//                                                           ),
//                                                         );
//                                                       },
//                                                     );
//                                                   },
//                                                   child: Stack(
//                                                     children: [
//                                                       SizedBox(
//                                                         height: 100,
//                                                         width: 70,
//                                                         child: Image.file(
//                                                           File(siteDiaryController.selectedImages[index].path),
//                                                           fit: BoxFit.cover,
//                                                         ),
//                                                       ),
//                                                       Positioned(
//                                                         top: 0,
//                                                         right: 0,
//                                                         child: InkWell(
//                                                           onTap: () async {
//                                                             siteDiaryController.selectedImages.removeAt(index);
//                                                           },
//                                                           child: const CircleAvatar(
//                                                             backgroundColor: AppColors.red,
//                                                             radius: 12,
//                                                             child: Icon(Icons.close, color: AppColors.white, size: 20),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                           );
//                                         },
//                                       ),
//                                     )
//                                   : const SizedBox();
//                             }),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 AppWidgets.addButton(
//                                     color: AppColors.white,
//                                     style: AppFonts.darkBlueColor16.copyWith(fontWeight: FontWeight.bold),
//                                     onPressed: () async {
//                                       if (worksList.isNotEmpty) {
//                                         String? userId = await HiveDB.getData(AppStrings.UID);
//                                         Map<String, dynamic> data = {
//                                           'user_id': userId,
//                                           'job_id': category,
//                                           'date': '${initialDate.year}-${initialDate.month}-${initialDate.day}',
//                                         };
//                                         if (widget.isEdit) {
//                                           data['site_diary_id'] = siteDiaryController.singleSiteDiary.first.id;
//                                         }
//                                         for (int i = 0; i < worksList.length; i++) {
//                                           data['trade[$i]'] = worksList[i].trade;
//                                           data['men_no[$i]'] = worksList[i].nom.toString();
//                                           data['hours_worked[$i]'] = worksList[i].hw.toString();
//                                           data['description[$i]'] = worksList[i].desc;
//                                         }
//                                         await siteDiaryController.addSiteDiaryData(data, isEdit: widget.isEdit);
//                                       } else {
//                                         AppWidgets.toast(msg: 'Add Works');
//                                       }
//                                     },
//                                     text: widget.isEdit ? 'EDIT AS DRAFT' : 'SAVE AS DRAFT',
//                                     minWidth: Get.width * 0.4),
//                                 AppWidgets.addButton(
//                                     color: AppColors.white,
//                                     style: AppFonts.darkBlueColor16.copyWith(fontWeight: FontWeight.bold),
//                                     onPressed: () async {
//                                       if (worksList.isNotEmpty) {
//                                         String? userId = await HiveDB.getData(AppStrings.UID);
//                                         Map<String, dynamic> data = {
//                                           'user_id': userId,
//                                           'job_id': category,
//                                           'status': '1',
//                                           'date': '${initialDate.year}-${initialDate.month}-${initialDate.day}',
//                                         };
//                                         if (widget.isEdit) {
//                                           data['site_diary_id'] = siteDiaryController.singleSiteDiary.first.id;
//                                         }
//                                         for (int i = 0; i < worksList.length; i++) {
//                                           data['trade[$i]'] = worksList[i].trade;
//                                           data['men_no[$i]'] = worksList[i].nom.toString();
//                                           data['hours_worked[$i]'] = worksList[i].hw.toString();
//                                           data['description[$i]'] = worksList[i].desc;
//                                         }
//                                         await siteDiaryController.addSiteDiaryData(data, isEdit: widget.isEdit);
//                                       } else {
//                                         AppWidgets.toast(msg: 'Add Works');
//                                       }
//                                     },
//                                     text: widget.isEdit ? 'EDIT REVIEW' : 'SUBMIT FOR REVIEW',
//                                     minWidth: Get.width * 0.4),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 30,
//                             )
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _addEditWorks() {
//     return SingleChildScrollView(
//       child: GestureDetector(
//         onTap: () => FocusScope.of(Get.context!).unfocus(),
//         child: Container(
//           color: AppColors.white,
//           child: ValueListenableBuilder(
//             valueListenable: dialogChange,
//             builder: (context, value, child) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     color: AppColors.darkBlue,
//                     width: Get.width,
//                     height: Get.height * 0.05,
//                     margin: const EdgeInsets.only(bottom: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const SizedBox(),
//                         AppWidgets.customText(text: 'ADD WORK', style: AppFonts.white18),
//                         InkWell(
//                           onTap: () => Get.back(),
//                           child: Container(
//                             color: AppColors.red,
//                             height: Get.height * 0.05,
//                             width: Get.width * 0.1,
//                             child: const Icon(
//                               Icons.clear,
//                               color: AppColors.darkBlue,
//                               size: 24,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 14.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(
//                           width: Get.width * 0.24,
//                           child: AppWidgets.customText(text: 'Trade', maxLines: 2, style: AppFonts.black18),
//                         ),
//                         SizedBox(
//                           width: Get.width * 0.44,
//                           child: AppWidgets.quoteFields(
//                             vertical: 0,
//                             color: AppColors.darkBlue,
//                             textEditingController: tradeController,
//                             hintText: 'Trade',
//                             hintStyle: AppFonts.white14.copyWith(color: Colors.white.withValues(alpha: 0.5)),
//                             textStyle: AppFonts.white14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   AppWidgets.sBox(height: 8),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 14.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(
//                           width: Get.width * 0.24,
//                           child: AppWidgets.customText(text: 'No. of Men', maxLines: 2, style: AppFonts.black18),
//                         ),
//                         SizedBox(
//                           width: Get.width * 0.44,
//                           child: AppWidgets.quoteFields(
//                             vertical: 0,
//                             color: AppColors.darkBlue,
//                             textEditingController: nomController,
//                             keyboardType: TextInputType.number,
//                             hintText: 'No. of man',
//                             hintStyle: AppFonts.white14.copyWith(color: Colors.white.withValues(alpha: 0.5)),
//                             textStyle: AppFonts.white14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   AppWidgets.sBox(height: 8),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 14.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(
//                           width: Get.width * 0.24,
//                           child: AppWidgets.customText(text: 'Hours Worked', maxLines: 2, style: AppFonts.black18),
//                         ),
//                         SizedBox(
//                           width: Get.width * 0.44,
//                           child: AppWidgets.quoteFields(
//                             vertical: 0,
//                             color: AppColors.darkBlue,
//                             textEditingController: hwController,
//                             keyboardType: TextInputType.number,
//                             hintText: 'Hours worked',
//                             hintStyle: AppFonts.white14.copyWith(color: Colors.white.withValues(alpha: 0.5)),
//                             textStyle: AppFonts.white14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   AppWidgets.sBox(height: 8),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 14.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(
//                           width: Get.width * 0.24,
//                           child: AppWidgets.customText(text: 'Description of work', maxLines: 2, style: AppFonts.black18),
//                         ),
//                         SizedBox(
//                           width: Get.width * 0.44,
//                           child: AppWidgets.quoteFields(
//                             vertical: 0,
//                             color: AppColors.darkBlue,
//                             textEditingController: dowController,
//                             hintText: 'Description',
//                             maxLine: 3,
//                             hintStyle: AppFonts.white14.copyWith(color: Colors.white.withValues(alpha: 0.5)),
//                             textStyle: AppFonts.white14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   AppWidgets.sBox(height: 8),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     child: MaterialButton(
//                       onPressed: () {
//                         if (tradeController.text.isEmpty) {
//                           AppWidgets.toast(msg: 'Add Trade!');
//                         } else if (nomController.text.isEmpty) {
//                           AppWidgets.toast(msg: 'Add No. of Men!');
//                         } else if (hwController.text.isEmpty) {
//                           AppWidgets.toast(msg: 'Add Hours Worked!');
//                         } else if (dowController.text.isEmpty) {
//                           AppWidgets.toast(msg: 'Add Description of Work!');
//                         } else {
//                           worksList.add(
//                             WorksModel(
//                               id: Random().nextInt(99999),
//                               trade: tradeController.text,
//                               nom: int.parse(nomController.text),
//                               hw: double.parse(hwController.text),
//                               desc: dowController.text,
//                             ),
//                           );
//                           change.value = Random().nextInt(9999999);
//                           Get.back();
//                         }
//                       },
//                       color: AppColors.green,
//                       // height: 45,
//                       minWidth: Get.width,
//                       child: AppWidgets.customText(text: 'SAVE DATA', style: AppFonts.white16.copyWith(fontWeight: FontWeight.bold)),
//                     ),
//                   ),
//                   AppWidgets.sBox(height: 15),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> init() async {
//     if (widget.isEdit) {
//       siteDiaryController.selectedImages.clear();
//       String dateString = siteDiaryController.singleSiteDiary.first.date;
//       DateFormat format = DateFormat("d MMM, y hh:mm a");
//       initialDate = format.parse(dateString);
//       category = siteDiaryController.singleSiteDiary.first.jobId;
//       for (var i in siteDiaryController.singleSiteDiary.first.siteDiaryDetails) {
//         worksList.add(
//           WorksModel(
//             id: int.parse(i.siteDetailId),
//             trade: i.trade,
//             nom: int.parse(i.menNo),
//             hw: double.parse(i.hoursWorked),
//             desc: i.description,
//           ),
//         );
//       }
//       if (siteDiaryController.singleSiteDiary.first.attachments.isNotEmpty && siteDiaryController.singleSiteDiary.first.attachments[0] != '') {
//         for (int i = 0; i < siteDiaryController.singleSiteDiary.first.attachments.length; i++) {
//           try {
//             String filePath = await AppUtils.downloadAndStoreImage(siteDiaryController.singleSiteDiary.first.attachments[i]);
//             XFile xFile = XFile(filePath);
//             siteDiaryController.selectedImages.add(xFile);
//           } catch (e) {
//             AppWidgets.toast(
//               msg: 'Error downloading attachment: $e',
//               backgroundColor: AppColors.red,
//             );
//           }
//         }
//       }
//     }
//   }
// }
