// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:sme/app/user/purchase_order/purchase_orders_add_view.dart';
// import 'package:sme/app/user/purchase_order/purchase_orders_logic.dart';
// import 'package:sme/app/user/purchase_order/widgets/purchase_order_widget.dart';
// import 'package:sme/utils/appconfig.dart';
// import 'package:sme/utils/appfonts.dart';
// import 'package:sme/utils/appcolor.dart';
// import 'package:sme/utils/appdatabase.dart';
// import 'package:sme/utils/appstring.dart';
// import 'package:sme/utils/apputils.dart';
// import 'package:sme/utils/appwidgets.dart';
// import 'model/PurchaseGetSiteModel.dart';
//
// class PurchaseOrderView extends StatefulWidget {
//   const PurchaseOrderView({super.key});
//
//   @override
//   State<PurchaseOrderView> createState() => _PurchaseOrderViewState();
// }
//
// class _PurchaseOrderViewState extends State<PurchaseOrderView> {
//   PurchaseController purchaseController = Get.put(PurchaseController());
//
//   @override
//   void initState() {
//     super.initState();
//     purchaseController.getPurchaseData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           AppWidgets.background(),
//           Obx(() {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 AppWidgets.commonAppBar(
//                   title: 'Purchase Orders',
//                   addVisible: true,
//                   onTap: () {
//                     AppUtils().playAudio(audioPlayer: AppWidgets.audioPlayer);
//                     Get.to(() => AddPurchaseOrderView(isEdit: false, title: "Request Purchase Order"));
//                   },
//                 ),
//                 purchaseController.isLoading.value == false
//                     ? Expanded(
//                         child: purchaseController.purchaseList.isEmpty
//                             ? Center(child: AppWidgets.noData())
//                             : RefreshIndicator(
//                                 color: AppColors.lightblue,
//                                 backgroundColor: AppColors.white,
//                                 onRefresh: () async {
//                                   await Future.delayed(const Duration(seconds: 1));
//                                   purchaseController.getPurchaseData();
//                                 },
//                                 child: RepaintBoundary(
//                                   child: ListView.builder(
//                                     padding: EdgeInsets.zero,
//                                     itemCount: purchaseController.purchaseList.length,
//                                     itemBuilder: (context, index) {
//                                       debugPrint("====PO STATUS==== ${purchaseController.purchaseGetData?.data?[index].poAttachments?.length}");
//                                       //PO Status 1 PO Requested
//                                       //PO Status 2
//                                       //PO Status 3 Approved
//                                       //PO Status 3.5 Paid For
//                                       //PO Status 4 Partially Delivered
//                                       return GestureDetector(
//                                         onTap: () {
//                                           debugPrint("====PO STATUS==== ${purchaseController.purchaseGetData?.data?[index].poStatus}");
//                                           AppUtils().playAudio(audioPlayer: AppWidgets.audioPlayer);
//                                           //poStatus1
//                                           if (purchaseController.purchaseGetData?.data?[index].poStatus == "1") {
//                                             status1Dialogue(context, index);
//                                           }
//                                           //poStatus3
//                                           else if (purchaseController.purchaseGetData?.data?[index].poStatus == "3") {
//                                             showModalBottomSheet(
//                                               context: context,
//                                               builder: (context) {
//                                                 return BackdropFilter(
//                                                   filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                                                   child: Container(
//                                                     color: Colors.white,
//                                                     child: Column(
//                                                       mainAxisSize: MainAxisSize.min,
//                                                       children: [
//                                                         Container(
//                                                           width: Get.width,
//                                                           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                                                           decoration: const BoxDecoration(
//                                                             color: AppColors.lightblue,
//                                                           ),
//                                                           child: Center(
//                                                             child: AppWidgets.snText(
//                                                               text: "PO Request ${purchaseController.purchaseGetData?.data?[index].poNumber}",
//                                                               style: AppFonts.black16.copyWith(
//                                                                 fontWeight: FontWeight.bold,
//                                                                 color: AppColors.white,
//                                                                 fontSize: 15.sp,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Row(
//                                                           children: [
//                                                             Expanded(
//                                                               child: Padding(
//                                                                 padding: const EdgeInsets.all(12),
//                                                                 child: GestureDetector(
//                                                                   onTap: () {
//                                                                     Get.back();
//                                                                     Get.to(() => AddPurchaseOrderView(isEdit: true, title: "Add Purchase Order", poId: purchaseController.purchaseGetData?.data?[index].poId));
//                                                                   },
//                                                                   child: Container(
//                                                                     height: 100,
//                                                                     width: Get.width,
//                                                                     decoration: BoxDecoration(
//                                                                       color: AppColors.lightGrey,
//                                                                       borderRadius: BorderRadius.circular(10),
//                                                                     ),
//                                                                     child: Column(
//                                                                       mainAxisAlignment: MainAxisAlignment.center,
//                                                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                                                       children: [
//                                                                         Padding(
//                                                                           padding: const EdgeInsets.all(8.0),
//                                                                           child: SvgPicture.asset(
//                                                                             "assets/svg/purchaseO.svg",
//                                                                             height: 50,
//                                                                           ),
//                                                                         ),
//                                                                         AppWidgets.snText(
//                                                                           text: "Edit Purchase Order",
//                                                                           style: AppFonts.black16.copyWith(
//                                                                             fontWeight: FontWeight.bold,
//                                                                             fontSize: 15.sp,
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             Expanded(
//                                                               child: Padding(
//                                                                 padding: const EdgeInsets.all(12),
//                                                                 child: GestureDetector(
//                                                                   onTap: () async {
//                                                                     Get.back();
//                                                                     await EasyLoading.show();
//                                                                     String url = purchaseController.purchaseGetData?.data?[index].pdfUrl ?? "";
//                                                                     final file = await PDFViewer.loadPdf(url);
//                                                                     purchaseController.openPdfFile(file, url);
//                                                                     EasyLoading.dismiss();
//                                                                   },
//                                                                   child: Container(
//                                                                     height: 100,
//                                                                     width: Get.width,
//                                                                     decoration: BoxDecoration(
//                                                                       color: AppColors.lightGrey,
//                                                                       borderRadius: BorderRadius.circular(10),
//                                                                     ),
//                                                                     child: Column(
//                                                                       mainAxisAlignment: MainAxisAlignment.center,
//                                                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                                                       children: [
//                                                                         Padding(
//                                                                           padding: const EdgeInsets.all(8.0),
//                                                                           child: SvgPicture.asset("assets/svg/pdf2.svg", height: 50),
//                                                                         ),
//                                                                         AppWidgets.snText(
//                                                                           text: "PDF View",
//                                                                           style: AppFonts.black16.copyWith(
//                                                                             fontWeight: FontWeight.bold,
//                                                                             fontSize: 15.sp,
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         const SizedBox(
//                                                           height: 20,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 );
//                                               },
//                                             );
//                                           }
//                                           //poStatus3.5
//                                           else if (purchaseController.purchaseGetData?.data?[index].poStatus == "3.5") {
//                                             showModalBottomSheet(
//                                               context: context,
//                                               builder: (context) {
//                                                 return BackdropFilter(
//                                                   filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                                                   child: Container(
//                                                     color: Colors.white,
//                                                     child: Column(
//                                                       mainAxisSize: MainAxisSize.min,
//                                                       children: [
//                                                         Container(
//                                                           width: Get.width,
//                                                           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                                                           decoration: const BoxDecoration(
//                                                             color: AppColors.lightblue,
//                                                           ),
//                                                           child: Center(
//                                                             child: AppWidgets.snText(
//                                                               text: "PO Request ${purchaseController.purchaseGetData?.data?[index].poNumber}",
//                                                               style: AppFonts.black16.copyWith(
//                                                                 fontWeight: FontWeight.bold,
//                                                                 color: AppColors.white,
//                                                                 fontSize: 15.sp,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Row(
//                                                           children: [
//                                                             Expanded(
//                                                               child: Padding(
//                                                                 padding: const EdgeInsets.all(12),
//                                                                 child: GestureDetector(
//                                                                   onTap: () async {
//                                                                     Get.back();
//                                                                     await EasyLoading.show();
//                                                                     String url = purchaseController.purchaseGetData?.data?[index].pdfUrl ?? "";
//                                                                     final file = await PDFViewer.loadPdf(url);
//                                                                     purchaseController.openPdfFile(file, url);
//                                                                     EasyLoading.dismiss();
//                                                                   },
//                                                                   child: Container(
//                                                                       height: 100,
//                                                                       width: Get.width,
//                                                                       decoration: BoxDecoration(
//                                                                         color: AppColors.lightGrey,
//                                                                         borderRadius: BorderRadius.circular(10),
//                                                                       ),
//                                                                       child: Column(
//                                                                         mainAxisAlignment: MainAxisAlignment.center,
//                                                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                                                         children: [
//                                                                           Padding(
//                                                                             padding: const EdgeInsets.all(8.0),
//                                                                             child: SvgPicture.asset(
//                                                                               "assets/svg/pdf2.svg",
//                                                                               height: 50,
//                                                                             ),
//                                                                           ),
//                                                                           AppWidgets.snText(
//                                                                             text: "PDF View",
//                                                                             style: AppFonts.black16.copyWith(
//                                                                               fontWeight: FontWeight.bold,
//                                                                               fontSize: 15.sp,
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       )),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             Expanded(
//                                                               child: Padding(
//                                                                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                                                                 child: GestureDetector(
//                                                                   onTap: () {
//                                                                     Get.back();
//                                                                     Get.to(() => AddPurchaseOrderView(
//                                                                           isEdit: true,
//                                                                           title: "Edit Purchase Order",
//                                                                           poId: purchaseController.purchaseGetData?.data?[index].poId,
//                                                                           supID: int.parse(purchaseController.purchaseGetData?.data?[index].supplierId ?? "0"),
//                                                                         ));
//                                                                   },
//                                                                   child: Container(
//                                                                     height: 100,
//                                                                     width: Get.width,
//                                                                     decoration: BoxDecoration(
//                                                                       color: AppColors.lightGrey,
//                                                                       borderRadius: BorderRadius.circular(10),
//                                                                     ),
//                                                                     child: Center(
//                                                                         child: Column(
//                                                                       mainAxisAlignment: MainAxisAlignment.center,
//                                                                       children: [
//                                                                         const Icon(
//                                                                           Icons.mode_edit_outline_outlined,
//                                                                           size: 50,
//                                                                           color: AppColors.black,
//                                                                         ),
//                                                                         AppWidgets.snText(
//                                                                           text: "Edit",
//                                                                           style: AppFonts.black16.copyWith(
//                                                                             fontWeight: FontWeight.bold,
//                                                                             fontSize: 15.sp,
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     )),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         GestureDetector(
//                                                           onTap: () async {
//                                                             Get.back();
//                                                             purchaseController.getContactDetailsBySupplierId(purchaseController.purchaseGetData?.data?[index].supplierId ?? "0");
//                                                             purchaseController.selectedContacts = <ContactEmail>[].obs;
//                                                             showDialog(
//                                                               context: context,
//                                                               builder: (BuildContext context) {
//                                                                 var contactList = purchaseController.getContactDetailsBySupplierId(purchaseController.purchaseGetData?.data?[index].supplierId ?? "0");
//                                                                 bool hasContacts = contactList.isNotEmpty;
//                                                                 return AlertDialog(
//                                                                   shape: RoundedRectangleBorder(
//                                                                     borderRadius: BorderRadius.circular(20),
//                                                                   ),
//                                                                   content: StatefulBuilder(
//                                                                     builder: (BuildContext context, StateSetter setState) {
//                                                                       return SizedBox(
//                                                                         height: Get.height * 0.5,
//                                                                         width: Get.width * 0.8,
//                                                                         child: Column(
//                                                                           children: [
//                                                                             Text(
//                                                                               "Select Supplier Contact",
//                                                                               style: AppFonts.black16.copyWith(
//                                                                                 fontWeight: FontWeight.bold,
//                                                                               ),
//                                                                             ),
//                                                                             Expanded(
//                                                                               child: hasContacts
//                                                                                   ? ListView.builder(
//                                                                                       itemCount: contactList.length,
//                                                                                       itemBuilder: (context, index) {
//                                                                                         var contact = contactList[index];
//                                                                                         bool isChecked = purchaseController.selectedContacts.any((selected) => selected.id == contact["ID"]);
//                                                                                         return ListTile(
//                                                                                           title: Text(
//                                                                                             "${contact["NAME"]} (${contact["EMAIL"]})",
//                                                                                             style: AppFonts.black14.copyWith(
//                                                                                               fontWeight: FontWeight.bold,
//                                                                                             ),
//                                                                                           ),
//                                                                                           trailing: Checkbox(
//                                                                                             value: isChecked,
//                                                                                             onChanged: (bool? value) {
//                                                                                               setState(() {
//                                                                                                 if (value == true) {
//                                                                                                   purchaseController.selectedContacts.add(ContactEmail(id: contact["ID"], name: contact["NAME"], email: contact["EMAIL"]));
//                                                                                                 } else {
//                                                                                                   purchaseController.selectedContacts.removeWhere((selected) => selected.id == contact["ID"]);
//                                                                                                 }
//                                                                                               });
//                                                                                             },
//                                                                                           ),
//                                                                                           onTap: () {
//                                                                                             setState(() {
//                                                                                               if (isChecked) {
//                                                                                                 purchaseController.selectedContacts.removeWhere((selected) => selected.id == contact["ID"]);
//                                                                                               } else {
//                                                                                                 purchaseController.selectedContacts.add(ContactEmail(id: contact["ID"], name: contact["NAME"], email: contact["EMAIL"]));
//                                                                                               }
//                                                                                             });
//                                                                                           },
//                                                                                         );
//                                                                                       },
//                                                                                     )
//                                                                                   : Center(
//                                                                                       child: Text(
//                                                                                         "No contacts available",
//                                                                                         style: AppFonts.black14.copyWith(
//                                                                                           fontWeight: FontWeight.bold,
//                                                                                         ),
//                                                                                       ),
//                                                                                     ),
//                                                                             ),
//                                                                             Row(
//                                                                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                                               children: [
//                                                                                 ElevatedButton(
//                                                                                   style: ElevatedButton.styleFrom(
//                                                                                     backgroundColor: AppColors.green,
//                                                                                   ),
//                                                                                   onPressed: () async {
//                                                                                     if (hasContacts) {
//                                                                                       Get.back();
//                                                                                       String userId = await HiveDB.getData(AppStrings.UID);
//                                                                                       purchaseController.sendPOMail(data: {
//                                                                                         "user_id": userId,
//                                                                                         "po_id": purchaseController.purchaseGetData?.data?[index].poId,
//                                                                                         "to_emails": purchaseController.selectedContacts.isEmpty ? "No contacts selected" : purchaseController.selectedContacts.map((contact) => contact.email).join(', '),
//                                                                                         "email_msg": "hey",
//                                                                                       });
//                                                                                     } else {
//                                                                                       Get.back();
//                                                                                       AppWidgets.toast(msg: "No contacts available", backgroundColor: AppColors.red);
//                                                                                     }
//                                                                                   },
//                                                                                   child: Padding(
//                                                                                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                                                                                     child: Text(
//                                                                                       "Send",
//                                                                                       style: AppFonts.white16,
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                                 ElevatedButton(
//                                                                                   style: ElevatedButton.styleFrom(
//                                                                                     backgroundColor: AppColors.red,
//                                                                                   ),
//                                                                                   onPressed: () {
//                                                                                     Get.back();
//                                                                                   },
//                                                                                   child: Padding(
//                                                                                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                                                                                     child: Text(
//                                                                                       "Cancel",
//                                                                                       style: AppFonts.white16,
//                                                                                     ),
//                                                                                   ),
//                                                                                 ),
//                                                                               ],
//                                                                             ),
//                                                                           ],
//                                                                         ),
//                                                                       );
//                                                                     },
//                                                                   ),
//                                                                 );
//                                                               },
//                                                             );
//                                                           },
//                                                           child: Container(
//                                                             height: 100,
//                                                             margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                                                             width: Get.width,
//                                                             decoration: BoxDecoration(
//                                                               color: AppColors.lightGrey,
//                                                               borderRadius: BorderRadius.circular(10),
//                                                             ),
//                                                             child: Column(
//                                                               mainAxisAlignment: MainAxisAlignment.center,
//                                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                                               children: [
//                                                                 const Padding(
//                                                                   padding: EdgeInsets.all(8.0),
//                                                                   child: Icon(
//                                                                     Icons.email_outlined,
//                                                                     size: 50,
//                                                                     color: AppColors.black,
//                                                                   ),
//                                                                 ),
//                                                                 AppWidgets.snText(
//                                                                   text: "Send Mail",
//                                                                   style: AppFonts.black16.copyWith(
//                                                                     fontWeight: FontWeight.bold,
//                                                                     fontSize: 15.sp,
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         const SizedBox(
//                                                           height: 20,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 );
//                                               },
//                                             );
//                                           }
//                                           //poStatus4
//                                           else if (purchaseController.purchaseGetData?.data?[index].poStatus == "4") {
//                                             showModalBottomSheet(
//                                               context: context,
//                                               builder: (context) {
//                                                 return BackdropFilter(
//                                                   filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                                                   child: Container(
//                                                     color: Colors.white,
//                                                     child: Column(
//                                                       mainAxisSize: MainAxisSize.min,
//                                                       children: [
//                                                         Container(
//                                                           width: Get.width,
//                                                           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                                                           decoration: const BoxDecoration(
//                                                             color: AppColors.lightblue,
//                                                           ),
//                                                           child: Center(
//                                                             child: AppWidgets.snText(
//                                                               text: "PO Request ${purchaseController.purchaseGetData?.data?[index].poNumber}",
//                                                               style: AppFonts.black16.copyWith(
//                                                                 fontWeight: FontWeight.bold,
//                                                                 color: AppColors.white,
//                                                                 fontSize: 15.sp,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Row(
//                                                           children: [
//                                                             Expanded(
//                                                               child: Padding(
//                                                                 padding: const EdgeInsets.all(12),
//                                                                 child: GestureDetector(
//                                                                   onTap: () async {
//                                                                     Get.back();
//                                                                     await EasyLoading.show();
//                                                                     String url = purchaseController.purchaseGetData?.data?[index].pdfUrl ?? "";
//                                                                     final file = await PDFViewer.loadPdf(url);
//                                                                     purchaseController.openPdfFile(file, url);
//                                                                     EasyLoading.dismiss();
//                                                                   },
//                                                                   child: Container(
//                                                                     padding: const EdgeInsets.all(8),
//                                                                     width: Get.width,
//                                                                     decoration: BoxDecoration(
//                                                                       color: AppColors.lightGrey,
//                                                                       borderRadius: BorderRadius.circular(10),
//                                                                     ),
//                                                                     child: Column(
//                                                                       mainAxisAlignment: MainAxisAlignment.center,
//                                                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                                                       children: [
//                                                                         Padding(
//                                                                           padding: const EdgeInsets.all(8.0),
//                                                                           child: SvgPicture.asset(
//                                                                             "assets/svg/pdf2.svg",
//                                                                             height: 50,
//                                                                           ),
//                                                                         ),
//                                                                         AppWidgets.snText(
//                                                                           text: "PDF",
//                                                                           style: AppFonts.black16.copyWith(
//                                                                             fontWeight: FontWeight.bold,
//                                                                             fontSize: 15.sp,
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             Expanded(child: Container()),
//                                                             // Expanded(
//                                                             //   child: Padding(
//                                                             //     padding: const EdgeInsets.all(12),
//                                                             //     child: GestureDetector(
//                                                             //       onTap: () async{
//                                                             //         if(purchaseController.purchaseGetData?.data?[index].grnData?.isEmpty ?? true){
//                                                             //           CommonWidgets.toast(msg: "No GRN Data Found");
//                                                             //           return;
//                                                             //         }else {
//                                                             //           await EasyLoading.show();
//                                                             //           String url = purchaseController.purchaseGetData?.data![index].grnData?[index].pdf ?? "";
//                                                             //           print("====PDF URL==== $url");
//                                                             //           final file = await PDFViewer
//                                                             //               .loadPdf(url);
//                                                             //           openPdfFile(file, url);
//                                                             //           EasyLoading.dismiss();
//                                                             //         }
//                                                             //       },
//                                                             //       child: Container(
//                                                             //           height: 100,
//                                                             //           width: Get.width,
//                                                             //           decoration: BoxDecoration(
//                                                             //             color: CC.lightGrey,
//                                                             //             borderRadius: BorderRadius.circular(10),
//                                                             //           ),
//                                                             //           child: Column(
//                                                             //             mainAxisAlignment: MainAxisAlignment.center,
//                                                             //             crossAxisAlignment: CrossAxisAlignment.center,
//                                                             //             children: [
//                                                             //               Padding(
//                                                             //                 padding: const EdgeInsets.all(8.0),
//                                                             //                 child: SvgPicture.asset("assets/svg/pdf2.svg", height: 50,),
//                                                             //               ),
//                                                             //               const Text("GRN PDF", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
//                                                             //             ],
//                                                             //           )
//                                                             //       ),
//                                                             //     ),
//                                                             //   ),
//                                                             // ),
//                                                           ],
//                                                         ),
//                                                         const SizedBox(
//                                                           height: 20,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 );
//                                               },
//                                             );
//                                           }
//                                           //poStatus5
//                                           else if (purchaseController.purchaseGetData?.data?[index].poStatus == "5") {
//                                             showModalBottomSheet(
//                                               context: context,
//                                               builder: (context) {
//                                                 return BackdropFilter(
//                                                   filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                                                   child: Container(
//                                                     height: 150,
//                                                     color: Colors.white,
//                                                     child: Column(
//                                                       children: [
//                                                         Row(
//                                                           children: [
//                                                             Expanded(
//                                                               child: Padding(
//                                                                 padding: const EdgeInsets.all(12),
//                                                                 child: GestureDetector(
//                                                                   onTap: () async {
//                                                                     Get.back();
//                                                                     await EasyLoading.show();
//                                                                     String url = purchaseController.purchaseGetData?.data?[index].pdfUrl ?? "";
//                                                                     final file = await PDFViewer.loadPdf(url);
//                                                                     purchaseController.openPdfFile(file, url);
//                                                                     EasyLoading.dismiss();
//                                                                   },
//                                                                   child: Container(
//                                                                     height: 100,
//                                                                     width: Get.width,
//                                                                     decoration: BoxDecoration(
//                                                                       color: AppColors.lightGrey,
//                                                                       borderRadius: BorderRadius.circular(10),
//                                                                     ),
//                                                                     child: Column(
//                                                                       mainAxisAlignment: MainAxisAlignment.center,
//                                                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                                                       children: [
//                                                                         Padding(
//                                                                           padding: const EdgeInsets.all(8.0),
//                                                                           child: SvgPicture.asset(
//                                                                             "assets/svg/pdf2.svg",
//                                                                             height: 50,
//                                                                           ),
//                                                                         ),
//                                                                         const Text(
//                                                                           "PDF",
//                                                                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             // Expanded(
//                                                             //   child: Padding(
//                                                             //     padding: const EdgeInsets.all(12),
//                                                             //     child: GestureDetector(
//                                                             //       onTap: () async{
//                                                             //         if(purchaseController.purchaseGetData?.data?[index].grnData?.isEmpty ?? true){
//                                                             //           CommonWidgets.toast(msg: "No GRN Data Found");
//                                                             //           return;
//                                                             //         }else {
//                                                             //           await EasyLoading.show();
//                                                             //           String url = purchaseController.purchaseGetData?.data![index].grnData?[index].pdf ?? "";
//                                                             //           print("====PDF URL==== $url");
//                                                             //           final file = await PDFViewer
//                                                             //               .loadPdf(url);
//                                                             //           openPdfFile(file, url);
//                                                             //           EasyLoading.dismiss();
//                                                             //         }
//                                                             //       },
//                                                             //       child: Container(
//                                                             //           height: 100,
//                                                             //           width: Get.width,
//                                                             //           decoration: BoxDecoration(
//                                                             //             color: CC.lightGrey,
//                                                             //             borderRadius: BorderRadius.circular(10),
//                                                             //           ),
//                                                             //           child: Column(
//                                                             //             mainAxisAlignment: MainAxisAlignment.center,
//                                                             //             crossAxisAlignment: CrossAxisAlignment.center,
//                                                             //             children: [
//                                                             //               Padding(
//                                                             //                 padding: const EdgeInsets.all(8.0),
//                                                             //                 child: SvgPicture.asset("assets/svg/pdf2.svg", height: 50,),
//                                                             //               ),
//                                                             //               const Text("GRN PDF", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
//                                                             //             ],
//                                                             //           )
//                                                             //       ),
//                                                             //     ),
//                                                             //   ),
//                                                             // ),
//                                                           ],
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 );
//                                               },
//                                             );
//                                           }
//                                           //poStatus6
//                                           else if (purchaseController.purchaseGetData?.data?[index].poStatus == "6") {
//                                             showModalBottomSheet(
//                                               context: context,
//                                               builder: (context) {
//                                                 return Container(
//                                                   height: 150,
//                                                   color: Colors.white,
//                                                   child: Column(
//                                                     children: [
//                                                       Row(
//                                                         children: [
//                                                           Expanded(
//                                                             child: Padding(
//                                                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                                                               child: GestureDetector(
//                                                                 onTap: () {
//                                                                   Get.back();
//                                                                   Get.to(() => AddPurchaseOrderView(isEdit: true, title: "Edit Purchase Order", poId: purchaseController.purchaseGetData?.data?[index].poId));
//                                                                 },
//                                                                 child: Column(
//                                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                   children: [
//                                                                     const Text(
//                                                                       "Resubmit the Order",
//                                                                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                                                                     ),
//                                                                     const SizedBox(
//                                                                       height: 5,
//                                                                     ),
//                                                                     Container(
//                                                                       height: 80,
//                                                                       width: Get.width,
//                                                                       decoration: BoxDecoration(
//                                                                         color: AppColors.lightGrey,
//                                                                         borderRadius: BorderRadius.circular(10),
//                                                                       ),
//                                                                       child: const Center(
//                                                                           child: Column(
//                                                                         mainAxisAlignment: MainAxisAlignment.center,
//                                                                         children: [
//                                                                           Icon(Icons.mode_edit, size: 50, color: AppColors.black),
//                                                                           Text("Edit", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                                                                         ],
//                                                                       )),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 );
//                                               },
//                                             );
//                                           }
//                                         },
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
//                                           child: AppWidgets.purchaseOrderCard(
//                                             statusName: purchaseController.purchaseGetData?.data?[index].poStatusName ?? "",
//                                             date2: purchaseController.purchaseGetData?.data?[index].poDate ?? "",
//                                             status: purchaseController.purchaseGetData?.data?[index].poStatus ?? "",
//                                             projectName: purchaseController.purchaseGetData?.data?[index].supplierName ?? "",
//                                             poNumber: purchaseController.purchaseGetData?.data?[index].poNumber ?? "",
//                                             jobNo: purchaseController.purchaseGetData?.data?[index].jobNo ?? "",
//                                             price: purchaseController.purchaseGetData?.data?[index].totalAmount ?? "",
//                                             attachments: purchaseController.purchaseGetData?.data?[index].poAttachments ?? [],
//                                           ).animate(
//                                             effects: [
//                                               SlideEffect(
//                                                 duration: const Duration(milliseconds: 600),
//                                                 curve: Curves.easeOutQuad,
//                                                 delay: const Duration(milliseconds: 100),
//                                                 begin: Offset(index.isEven ? 1 : -1, 0),
//                                                 end: Offset.zero,
//                                               ),
//                                               const FadeEffect(
//                                                 duration: Duration(milliseconds: 600),
//                                                 delay: Duration(milliseconds: 100),
//                                                 curve: Curves.easeOutQuad,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                       )
//                     : PurchaseOrderWidget.purchaseOrderShimmer(),
//               ],
//             );
//           })
//         ],
//       ),
//     );
//   }
//
//   Future<dynamic> status1Dialogue(BuildContext context, int index) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//           child: AlertDialog(
//             backgroundColor: AppColors.white,
//             surfaceTintColor: AppColors.white,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0), side: const BorderSide(color: AppColors.white, width: 1.5)),
//             contentPadding: const EdgeInsets.all(0),
//             titlePadding: const EdgeInsets.all(0),
//             insetPadding: const EdgeInsets.all(20),
//             actionsPadding: const EdgeInsets.all(0),
//             buttonPadding: const EdgeInsets.all(0),
//             iconPadding: const EdgeInsets.all(0),
//             actionsOverflowButtonSpacing: 0,
//             title: Container(
//               width: Get.width,
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//               decoration: const BoxDecoration(
//                 color: AppColors.lightblue,
//               ),
//               child: Center(
//                 child: AppWidgets.snText(
//                   text: "PO Request ${purchaseController.purchaseGetData?.data?[index].poNumber}",
//                   style: AppFonts.black16.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.white,
//                     fontSize: 15.sp,
//                   ),
//                 ),
//               ),
//             ),
//             content: SingleChildScrollView(
//               padding: EdgeInsets.zero,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 25),
//                   AppWidgets.snText(
//                     text: "Do you want to Edit this PO Request?",
//                     style: AppFonts.black16.copyWith(fontWeight: FontWeight.w500, fontSize: 15.sp),
//                   ),
//                   const SizedBox(height: 25),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                             backgroundColor: AppColors.green,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(0),
//                             ),
//                           ),
//                           onPressed: () {
//                             Get.back();
//                             Get.to(() => AddPurchaseOrderView(isEdit: false, title: "Edit Request Purchase Order", poId: purchaseController.purchaseGetData?.data?[index].poId));
//                           },
//                           child: AppWidgets.snText(
//                             text: "Yes",
//                             style: AppFonts.white16.copyWith(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14.sp,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.red,
//                             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(0),
//                             ),
//                           ),
//                           onPressed: () => Get.back(),
//                           child: AppWidgets.snText(
//                             text: "No",
//                             style: AppFonts.white16.copyWith(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14.sp,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
