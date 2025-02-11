// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:sme/app/user/purchase_order/imports.dart';
//
// class AddPurchaseOrderView extends StatefulWidget {
//   AddPurchaseOrderView({super.key, required this.isEdit, this.title, this.poId, this.supID});
//
//   bool isEdit;
//   String? title;
//   String? poId;
//   int? supID;
//
//   @override
//   State<AddPurchaseOrderView> createState() => _AddPurchaseOrderViewState();
// }
//
// class _AddPurchaseOrderViewState extends State<AddPurchaseOrderView> {
//   CategoryController categoryController = Get.put(CategoryController());
//   CategoryListController categoryProductController = Get.put(CategoryListController());
//   PurchaseController purchaseController = Get.put(PurchaseController());
//   SiteController siteController = Get.put(SiteController());
//
//   DateTime dateOrder = DateTime.now();
//   DateTime selectedDate = DateTime.now();
//   String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
//   String dateOrder2 = DateFormat('dd-MM-yyyy').format(DateTime.now());
//   String apiDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
//   String apiDate2 = DateFormat('yyyy-MM-dd').format(DateTime.now());
//
//   TextEditingController referenceController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController estimatedAmount = TextEditingController();
//   TextEditingController noteController = TextEditingController();
//   TextEditingController deliveryAddController = TextEditingController();
//   TextEditingController customSupplierController = TextEditingController();
//   TextEditingController searchController = TextEditingController();
//
//   ValueNotifier<int> listChange = ValueNotifier(0);
//   List<SubCategory2> subCategoryList = [];
//   List<ProductElement> productList = [];
//   List<Product2> productList2 = [];
//
//   String rootCatName = '';
//   String subCatName = '';
//
//   RxBool rootCatShow = true.obs;
//   RxBool subCatShow = false.obs;
//   RxBool productShow = false.obs;
//   RxBool searchProductShow = false.obs;
//
//   RxInt selectIndex = (-1).obs;
//
//   RxString category = '1'.obs;
//   RxString selectedProject = "--".obs;
//   RxString plantName = "".obs;
//   RxString deliveryType = "1".obs;
//
//   String siteAddress = 'Select Project';
//   String selectedSupplier = "--";
//   String customSupplier = "";
//   String supplierID = "0";
//
//   List<PurchaseProductModel> plantProduct = [], materialProduct = [], accessProduct = [];
//
//   @override
//   void initState() {
//     super.initState();
//     purchaseController.clearData();
//     purchaseController.getPOSiteData();
//     categoryController.getCategoryData();
//     categoryController.getDeliveryData();
//     purchaseController.poNumber.value = "";
//     deliveryType.value = "1";
//     widget.title != "Request Purchase Order" ? getEditData(widget.title!) : null;
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//         formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
//         apiDate = DateFormat('yyyy-MM-dd').format(selectedDate);
//       });
//     }
//   }
//
//   Future<void> selectedOrderDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: dateOrder,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != dateOrder) {
//       setState(() {
//         dateOrder = picked;
//         dateOrder2 = DateFormat('dd-MM-yyyy').format(dateOrder);
//         apiDate2 = DateFormat('yyyy-MM-dd').format(dateOrder);
//       });
//     }
//   }
//
//   Future<void> getEditData(String tit) async {
//     EasyLoading.show();
//     await purchaseController.getSingleData(widget.poId ?? "").whenComplete(() {
//       purchaseController.refreshScreen.value = Random().nextInt(9999999);
//       purchaseController.refreshScreen.value = Random().nextInt(9999999);
//       purchaseController.refreshScreen.value = Random().nextInt(9999999);
//     });
//
//     // This is For Edit Request Purchase Order
//     if (tit == "Edit Request Purchase Order") {
//       purchaseController.poNumber.value = purchaseController.singleDataList.first.poData!.poNumber.toString();
//       selectedProject.value = purchaseController.singleDataList.first.poData!.projectName.toString();
//       supplierID = purchaseController.singleDataList.first.poData!.supplierId.toString();
//       selectedSupplier = purchaseController.singleDataList.first.poData!.supplierName.toString();
//       selectedDate = purchaseController.singleDataList.first.poData!.poDate!;
//       estimatedAmount.text = purchaseController.singleDataList.first.poData!.totalAmount.toString();
//       noteController.text = purchaseController.singleDataList.first.poData!.additionalNotes.toString();
//       dateOrder = DateFormat('yyyy-MM-dd').parse(purchaseController.singleDataList.first.poData!.poDate!.toString());
//       dateOrder2 = DateFormat('dd-MM-yyyy').format(purchaseController.singleDataList.first.poData!.poDate!);
//       apiDate2 = DateFormat('yyyy-mm-dd').format(purchaseController.singleDataList.first.poData!.poDate!);
//       List<PurchaseOrderDatum2>? plant = purchaseController.singleDataList.first.poDetails?.plantData;
//       List<PurchaseOrderDatum2>? material = purchaseController.singleDataList.first.poDetails?.materialData;
//       List<PurchaseOrderDatum2>? ae = purchaseController.singleDataList.first.poDetails?.accessEquipmentData;
//
//       setState(
//         () {
//           plantProduct.clear();
//           materialProduct.clear();
//           accessProduct.clear();
//           plantProduct.addAll(
//             plant!.map(
//               (e) => PurchaseProductModel(
//                 items: e.itemName ?? "",
//                 productId: e.item,
//                 qty: e.qty ?? "",
//                 itemID: e.item ?? "",
//                 itemTotalPrice: e.amount ?? "",
//                 itemPrice: e.unitprice ?? "",
//               ),
//             ),
//           );
//           materialProduct.addAll(
//             material!.map(
//               (e) => PurchaseProductModel(
//                 items: e.itemName ?? "",
//                 qty: e.qty ?? "",
//                 itemID: e.item ?? "",
//                 itemTotalPrice: e.amount ?? "",
//                 itemPrice: e.unitprice ?? "",
//                 itemName: e.itemName ?? "",
//                 emsCode: e.emsCode ?? "",
//                 partNO: e.partNo ?? "",
//               ),
//             ),
//           );
//           accessProduct.addAll(ae!.map(
//             (e) => PurchaseProductModel(
//               productId: e.item,
//               items: e.itemName ?? "",
//               qty: e.qty ?? "",
//               itemID: e.item ?? "",
//               itemTotalPrice: e.amount ?? "",
//               itemPrice: e.unitprice ?? "",
//               itemName: e.itemName ?? "",
//             ),
//           ));
//           categoryProductController.isVisible.value = true;
//           categoryProductController.isVisible2.value = true;
//           categoryProductController.isVisible3.value = true;
//           purchaseController.refreshScreen.value = Random().nextInt(9999999);
//           purchaseController.refreshScreen.value = Random().nextInt(9999999);
//
//           categoryProductController.calculateTotals(plantProduct, materialProduct, accessProduct);
//         },
//       );
//
//       if (purchaseController.singleDataList.first.poData?.aTTACHMENTS?.isNotEmpty ?? false) {
//         purchaseController.selectedImages.clear();
//         for (int i = 0; i < purchaseController.singleDataList.first.poData!.aTTACHMENTS!.length; i++) {
//           String attachmentUrl = purchaseController.singleDataList.first.poData!.aTTACHMENTS![i].iMAGE!;
//           String filePath = await AppUtils.downloadAndStoreImage(attachmentUrl);
//           XFile xFile = XFile(filePath);
//           purchaseController.selectedImages.add(xFile);
//         }
//       }
//
//       purchaseController.refreshImagesChange.value = Random().nextInt(9999999);
//       purchaseController.refreshImagesChange.value = Random().nextInt(9999999);
//     }
//     // This if For Add Purchase Order
//     else if (tit == "Add Purchase Order") {
//       purchaseController.getContactDetailsBySupplierId(widget.supID.toString());
//       purchaseController.getPOSiteData();
//       purchaseController.poNumber.value = purchaseController.singleDataList.first.poData!.poNumber.toString();
//       selectedProject.value = purchaseController.singleDataList.first.poData!.projectName.toString();
//       selectedSupplier = purchaseController.singleDataList.first.poData!.supplierName.toString();
//       supplierID = purchaseController.singleDataList.first.poData!.supplierId.toString();
//       dateOrder = DateFormat('yyyy-MM-dd').parse(purchaseController.singleDataList.first.poData!.poDate!.toString());
//       selectedDate = purchaseController.singleDataList.first.poData!.poDate!;
//       formattedDate = DateFormat('dd-MM-yyyy').format(purchaseController.singleDataList.first.poData!.poDate!);
//       apiDate = DateFormat('yyyy-mm-dd').format(purchaseController.singleDataList.first.poData!.poDate!);
//       List<PurchaseOrderDatum2>? plant = purchaseController.singleDataList.first.poDetails?.plantData;
//       List<PurchaseOrderDatum2>? material = purchaseController.singleDataList.first.poDetails?.materialData;
//       List<PurchaseOrderDatum2>? ae = purchaseController.singleDataList.first.poDetails?.accessEquipmentData;
//       noteController.text = purchaseController.singleDataList.first.poData!.additionalNotes.toString();
//
//       setState(() {
//         plantProduct.clear();
//         materialProduct.clear();
//         accessProduct.clear();
//         plantProduct.addAll(
//           plant!.map(
//             (e) => PurchaseProductModel(
//               items: e.itemName ?? "",
//               productId: e.item,
//               qty: e.qty ?? "",
//               itemID: e.item ?? "",
//               itemTotalPrice: e.amount ?? "",
//               itemPrice: e.unitprice ?? "",
//             ),
//           ),
//         );
//         materialProduct.addAll(
//           material!.map(
//             (e) => PurchaseProductModel(
//               items: e.itemName ?? "",
//               qty: e.qty ?? "",
//               itemID: e.item ?? "",
//               itemTotalPrice: e.amount ?? "",
//               itemPrice: e.unitprice ?? "",
//               itemName: e.itemName ?? "",
//               emsCode: e.emsCode ?? "",
//               partNO: e.partNo ?? "",
//             ),
//           ),
//         );
//         accessProduct.addAll(
//           ae!.map(
//             (e) => PurchaseProductModel(
//               productId: e.item,
//               items: e.itemName ?? "",
//               qty: e.qty ?? "",
//               itemID: e.item ?? "",
//               itemTotalPrice: e.amount ?? "",
//               itemPrice: e.unitprice ?? "",
//               itemName: e.itemName ?? "",
//             ),
//           ),
//         );
//
//         debugPrint("Plant Data: ${plantProduct.length}");
//         debugPrint("Material Data: ${materialProduct.length}");
//         debugPrint("Accessories Data: ${accessProduct.length}");
//         categoryProductController.isVisible.value = true;
//         categoryProductController.isVisible2.value = true;
//         categoryProductController.isVisible3.value = true;
//         categoryProductController.calculateTotals(plantProduct, materialProduct, accessProduct);
//       });
//
//       if (purchaseController.singleDataList.first.poData?.aTTACHMENTS?.isNotEmpty ?? false) {
//         purchaseController.selectedImages.clear();
//         for (int i = 0; i < purchaseController.singleDataList.first.poData!.aTTACHMENTS!.length; i++) {
//           String attachmentUrl = purchaseController.singleDataList.first.poData!.aTTACHMENTS![i].iMAGE!;
//           String filePath = await AppUtils.downloadAndStoreImage(attachmentUrl);
//           XFile xFile = XFile(filePath);
//           purchaseController.selectedImages.add(xFile);
//         }
//       }
//
//       purchaseController.refreshScreen.value = Random().nextInt(9999999);
//       purchaseController.refreshScreen.value = Random().nextInt(9999999);
//       purchaseController.refreshImagesChange.value = Random().nextInt(9999999);
//       purchaseController.refreshImagesChange.value = Random().nextInt(9999999);
//     }
//     // This if For Edit Purchase Order
//     else if (tit == "Edit Purchase Order") {
//       purchaseController.getContactDetailsBySupplierId(widget.supID.toString());
//       purchaseController.getPOSiteData();
//       purchaseController.poNumber.value = purchaseController.singleDataList.first.poData!.poNumber.toString();
//       selectedProject.value = purchaseController.singleDataList.first.poData!.projectName.toString();
//       referenceController.text = purchaseController.singleDataList.first.poData!.referanceNumber.toString();
//       category.value = purchaseController.singleDataList.first.poData!.jobId.toString();
//       selectedSupplier = purchaseController.singleDataList.first.poData!.supplierName.toString();
//       addressController.text = purchaseController.singleDataList.first.poData!.fullDeliveryAddress.toString();
//       noteController.text = purchaseController.singleDataList.first.poData!.additionalNotes.toString();
//       supplierID = purchaseController.singleDataList.first.poData!.supplierId.toString();
//       selectedDate = purchaseController.singleDataList.first.poData!.poDate!;
//       formattedDate = DateFormat('dd-MM-yyyy').format(purchaseController.singleDataList.first.poData!.poDate!);
//       dateOrder = DateFormat('yyyy-MM-dd').parse(purchaseController.singleDataList.first.poData!.poDate!.toString());
//       dateOrder2 = DateFormat('dd-MM-yyyy').format(purchaseController.singleDataList.first.poData!.expDeliveryDate!);
//       apiDate = DateFormat('yyyy-MM-dd').format(purchaseController.singleDataList.first.poData!.poDate!);
//       apiDate2 = DateFormat('yyyy-MM-dd').format(purchaseController.singleDataList.first.poData!.expDeliveryDate!);
//       List<PurchaseOrderDatum2>? plant = purchaseController.singleDataList.first.poDetails?.plantData;
//       List<PurchaseOrderDatum2>? material = purchaseController.singleDataList.first.poDetails?.materialData;
//       List<PurchaseOrderDatum2>? ae = purchaseController.singleDataList.first.poDetails?.accessEquipmentData;
//       List<SupplierContact>? contactList = purchaseController.singleDataList.first.poData!.supplierContacts;
//
//       setState(() {
//         plantProduct.clear();
//         materialProduct.clear();
//         accessProduct.clear();
//         purchaseController.selectedContacts.clear();
//         plantProduct.addAll(
//           plant!.map(
//             (e) => PurchaseProductModel(
//               items: e.itemName ?? "",
//               productId: e.item,
//               qty: e.qty ?? "",
//               itemID: e.item ?? "",
//               itemTotalPrice: e.amount ?? "",
//               itemPrice: e.unitprice ?? "",
//             ),
//           ),
//         );
//         materialProduct.addAll(
//           material!.map(
//             (e) => PurchaseProductModel(
//               items: e.itemName ?? "",
//               qty: e.qty ?? "",
//               itemID: e.item ?? "",
//               itemTotalPrice: e.amount ?? "",
//               itemPrice: e.unitprice ?? "",
//               itemName: e.itemName ?? "",
//               emsCode: e.emsCode ?? "",
//               partNO: e.partNo ?? "",
//             ),
//           ),
//         );
//         accessProduct.addAll(
//           ae!.map(
//             (e) => PurchaseProductModel(
//               productId: e.item,
//               items: e.itemName ?? "",
//               qty: e.qty ?? "",
//               itemID: e.item ?? "",
//               itemTotalPrice: e.amount ?? "",
//               itemPrice: e.unitprice ?? "",
//               itemName: e.itemName ?? "",
//             ),
//           ),
//         );
//         purchaseController.selectedContacts.addAll(
//           contactList!.map((e) => ContactEmail(id: e.id, name: e.name)),
//         );
//         debugPrint("Plant Data: ${plantProduct.length}");
//         debugPrint("Material Data: ${materialProduct.length}");
//         debugPrint("Accessories Data: ${accessProduct.length}");
//         categoryProductController.isVisible.value = true;
//         categoryProductController.isVisible2.value = true;
//         categoryProductController.isVisible3.value = true;
//         categoryProductController.calculateTotals(plantProduct, materialProduct, accessProduct);
//       });
//       if (purchaseController.singleDataList.first.poData?.aTTACHMENTS?.isNotEmpty ?? false) {
//         purchaseController.selectedImages.clear();
//         for (int i = 0; i < purchaseController.singleDataList.first.poData!.aTTACHMENTS!.length; i++) {
//           String attachmentUrl = purchaseController.singleDataList.first.poData!.aTTACHMENTS![i].iMAGE!;
//           String filePath = await AppUtils.downloadAndStoreImage(attachmentUrl);
//           XFile xFile = XFile(filePath);
//           purchaseController.selectedImages.add(xFile);
//         }
//       }
//       purchaseController.refreshScreen.value = Random().nextInt(9999999);
//       purchaseController.refreshScreen.value = Random().nextInt(9999999);
//       purchaseController.refreshImagesChange.value = Random().nextInt(9999999);
//       purchaseController.refreshImagesChange.value = Random().nextInt(9999999);
//     }
//     // This if For Add Request Purchase Order
//     else {}
//     EasyLoading.dismiss();
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
//               valueListenable: purchaseController.refreshScreen,
//               builder: (context, c, h) {
//                 return Column(
//                   children: [
//                     AppWidgets.commonAppBar(title: widget.title),
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (widget.isEdit)
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
//                                       decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(0)),
//                                       child: AppWidgets.snText(
//                                         text: "Select Option",
//                                         style: AppFonts.lightBlueColor18.copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp),
//                                       ),
//                                     ),
//                                     Container(
//                                       decoration: BoxDecoration(color: AppColors.lightblue, borderRadius: BorderRadius.circular(0)),
//                                       child: Row(
//                                         children: [
//                                           Obx(() {
//                                             return Radio<bool>(
//                                               value: true,
//                                               groupValue: purchaseController.isCollection.value,
//                                               activeColor: AppColors.green,
//                                               fillColor: purchaseController.isCollection.value ? WidgetStateProperty.all(Colors.green) : WidgetStateProperty.all(Colors.white),
//                                               onChanged: (value) {
//                                                 purchaseController.isCollection.value = value!;
//                                                 deliveryType.value = "1";
//                                               },
//                                             );
//                                           }),
//                                           AppWidgets.snText(
//                                             text: 'Delivery',
//                                             style: AppFonts.white18.copyWith(fontWeight: FontWeight.bold, fontSize: 15.sp),
//                                           ),
//                                           Obx(() {
//                                             return Radio<bool>(
//                                               value: false,
//                                               groupValue: purchaseController.isCollection.value,
//                                               activeColor: AppColors.green,
//                                               fillColor: purchaseController.isCollection.value ? WidgetStateProperty.all(Colors.white) : WidgetStateProperty.all(Colors.green),
//                                               onChanged: (value) {
//                                                 purchaseController.isCollection.value = value!;
//                                                 addressController.clear();
//                                                 deliveryType.value = "2";
//                                               },
//                                             );
//                                           }),
//                                           AppWidgets.snText(
//                                             text: 'Collection',
//                                             style: AppFonts.white18.copyWith(fontWeight: FontWeight.w600, fontSize: 15.sp),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             //Reference Number
//                             if (widget.isEdit)
//                               AppWidgets.commonUI(
//                                 isShowWidget: true,
//                                 title: "Reference Number",
//                                 widget: Container(
//                                   height: Get.height * 0.05,
//                                   width: Get.width,
//                                   decoration: const BoxDecoration(color: AppColors.lightblue),
//                                   child: AppWidgets.quoteFieldsCommonUI(
//                                     textEditingController: referenceController,
//                                     hintText: 'Enter Reference Number',
//                                     width: Get.width * 0.9,
//                                   ),
//                                 ),
//                               ),
//                             //Select Supplier
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Obx(() {
//                                     return AppWidgets.commonUI(
//                                       width1: Get.width * 0.9,
//                                       title: "PO#",
//                                       value: purchaseController.poNumber.value,
//                                       isShowWidget: true,
//                                       widget: Container(
//                                         padding: const EdgeInsets.symmetric(horizontal: 5),
//                                         alignment: Alignment.centerLeft,
//                                         height: Get.height * 0.05,
//                                         width: Get.width,
//                                         decoration: BoxDecoration(color: AppColors.lightblue.withValues(alpha: 0.4)),
//                                         child: AppWidgets.snText(
//                                           text: purchaseController.poNumber.value == "" ? "-" : purchaseController.poNumber.value,
//                                           style: AppFonts.white16.copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp),
//                                         ),
//                                       ),
//                                     );
//                                   }),
//                                 ),
//                                 //PO Date
//                                 if (!widget.isEdit)
//                                   Expanded(
//                                     child: AppWidgets.commonUI(
//                                       title: "PO Date",
//                                       onTap: () => selectedOrderDate(context),
//                                       value: DateFormat('dd MMM yyyy').format(dateOrder),
//                                       isIconShow: true,
//                                       icon: Icons.calendar_month_outlined,
//                                     ),
//                                   ),
//                               ],
//                             ),
//                             //Select Project/Site
//                             Obx(
//                               () {
//                                 return AppWidgets.commonUI(
//                                   title: "Select Project/Site",
//                                   value: selectedProject.value,
//                                   onTap: () {
//                                     if (widget.title == "Request Purchase Order") {
//                                       showSiteModal(context);
//                                     } else {
//                                       AppWidgets.toast(msg: "You can't change site address in edit mode");
//                                     }
//                                   },
//                                   icon: Icons.arrow_drop_down_outlined,
//                                   isIconShow: true,
//                                 );
//                               },
//                             ),
//
//                             AppWidgets.commonUI(
//                               title: "Select Supplier",
//                               value: selectedSupplier,
//                               onTap: () => selectSupplierSheet(context),
//                               icon: Icons.arrow_drop_down_outlined,
//                               isIconShow: true,
//                             ),
//                             // Select Supplier Contact
//                             if (widget.isEdit)
//                               Obx(() {
//                                 return AppWidgets.commonUI(
//                                   title: "Select Supplier Contact",
//                                   value: purchaseController.selectedContacts.isEmpty ? "No contacts selected" : purchaseController.selectedContacts.map((contact) => contact.name).join(', '),
//                                   onTap: () => selectSupplierContactDialogue(context),
//                                   icon: Icons.arrow_drop_down_outlined,
//                                   isIconShow: true,
//                                 );
//                               }),
//
//                             if (widget.isEdit)
//                               Obx(() {
//                                 return Visibility(
//                                   visible: purchaseController.isCollection.value,
//                                   child: AppWidgets.commonUI(
//                                     isShowWidget: true,
//                                     title: "Full Delivery Address",
//                                     widget: Container(
//                                       height: Get.height * 0.08,
//                                       width: Get.width,
//                                       decoration: const BoxDecoration(color: AppColors.lightblue),
//                                       child: AppWidgets.quoteFieldsCommonUI(textEditingController: addressController, maxLine: 3, svgShow: false),
//                                     ),
//                                   ),
//                                 );
//                               }),
//                             //Date Ordered and Expected Delivery Date
//                             if (widget.isEdit)
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: AppWidgets.commonUI(
//                                       title: "Delivery Date",
//                                       value: formattedDate,
//                                       onTap: () => _selectDate(context),
//                                       icon: Icons.calendar_today,
//                                       isIconShow: true,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: AppWidgets.commonUI(
//                                       title: "Expected Delivery Date",
//                                       value: dateOrder2,
//                                       onTap: () => selectedOrderDate(context),
//                                       icon: Icons.calendar_today,
//                                       isIconShow: true,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             // Add Buttons
//                             Row(
//                               children: [
//                                 //add plant
//                                 Expanded(
//                                   child: AppWidgets.dialogueButton(
//                                     title: "ADD\nPLANT/TOOLS",
//                                     onTap: () {
//                                       clearDialogueValues();
//                                       addPlanDialogue(context);
//                                     },
//                                   ),
//                                 ),
//                                 //add material
//                                 Expanded(
//                                   child: AppWidgets.dialogueButton(
//                                     title: "ADD\nMATERIALS",
//                                     onTap: () {
//                                       clearDialogueValues();
//                                       addMaterialDialogue(context);
//                                     },
//                                   ),
//                                 ),
//                                 //add access
//                                 Expanded(
//                                   child: AppWidgets.dialogueButton(
//                                     title: "ADD\nEQUIPMENT",
//                                     onTap: () {
//                                       clearDialogueValues();
//                                       addAccessEquipmentDialogue(context);
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             //A add plant
//                             ValueListenableBuilder(
//                               valueListenable: listChange,
//                               builder: (context, value, child) {
//                                 return Visibility(
//                                   visible: categoryProductController.isVisible.value,
//                                   child: ListView.builder(
//                                     shrinkWrap: true,
//                                     physics: const NeverScrollableScrollPhysics(),
//                                     padding: EdgeInsets.zero,
//                                     itemCount: plantProduct.length,
//                                     itemBuilder: (context, index) {
//                                       return AppWidgets.customProductTile(
//                                         onTap: () {
//                                           categoryProductController.counter.value = int.parse(plantProduct[index].qty);
//                                           categoryProductController.unitPrice.value = double.parse(plantProduct[index].itemPrice);
//                                           categoryProductController.totalPrice.value = categoryProductController.unitPrice.value * categoryProductController.counter.value;
//                                           categoryProductController.unitPriceController.text = categoryProductController.unitPrice.value.toString();
//                                           //  Show alert box
//                                           planToolEditQtyDialogue(context, index);
//                                         },
//                                         title: plantProduct[index].items,
//                                         itemPrice: plantProduct[index].itemPrice,
//                                         itemTotalPrice: plantProduct[index].itemTotalPrice,
//                                         qty: plantProduct[index].qty,
//                                       );
//                                     },
//                                   ),
//                                 );
//                               },
//                             ),
//                             //B add material
//                             ValueListenableBuilder(
//                               valueListenable: listChange,
//                               builder: (context, value, child) {
//                                 return Visibility(
//                                   visible: categoryProductController.isVisible2.value,
//                                   child: ListView.builder(
//                                     shrinkWrap: true,
//                                     physics: const NeverScrollableScrollPhysics(),
//                                     padding: EdgeInsets.zero,
//                                     itemCount: materialProduct.length,
//                                     itemBuilder: (context, index) {
//                                       return AppWidgets.customProductTile(
//                                         onTap: () {
//                                           categoryProductController.counter.value = int.parse(materialProduct[index].qty);
//                                           categoryProductController.unitPrice.value = double.parse(materialProduct[index].itemPrice);
//                                           categoryProductController.totalPrice.value = categoryProductController.unitPrice.value * categoryProductController.counter.value;
//                                           categoryProductController.unitPriceController.text = categoryProductController.unitPrice.value.toString();
//                                           //show alert box
//                                           materialEditQtyDialogue(context, index);
//                                         },
//                                         title: materialProduct[index].items,
//                                         itemPrice: materialProduct[index].itemPrice,
//                                         itemTotalPrice: materialProduct[index].itemTotalPrice,
//                                         qty: materialProduct[index].qty,
//                                       );
//                                     },
//                                   ),
//                                 );
//                               },
//                             ),
//                             // C add services
//                             ValueListenableBuilder(
//                               valueListenable: listChange,
//                               builder: (context, value, child) {
//                                 return Visibility(
//                                   visible: categoryProductController.isVisible3.value,
//                                   child: ListView.builder(
//                                     shrinkWrap: true,
//                                     physics: const NeverScrollableScrollPhysics(),
//                                     padding: EdgeInsets.zero,
//                                     itemCount: accessProduct.length,
//                                     itemBuilder: (context, index) {
//                                       return AppWidgets.customProductTile(
//                                         onTap: () {
//                                           categoryProductController.counter.value = int.parse(accessProduct[index].qty);
//                                           categoryProductController.unitPrice.value = double.parse(accessProduct[index].itemPrice);
//                                           categoryProductController.totalPrice.value = categoryProductController.unitPrice.value * categoryProductController.counter.value;
//                                           categoryProductController.unitPriceController.text = categoryProductController.unitPrice.value.toString();
//                                           //show alert box
//                                           accessEquipmentEditQtyDialogue(context, index);
//                                         },
//                                         title: accessProduct[index].items,
//                                         itemPrice: accessProduct[index].itemPrice,
//                                         itemTotalPrice: accessProduct[index].itemTotalPrice,
//                                         qty: accessProduct[index].qty,
//                                       );
//                                     },
//                                   ),
//                                 );
//                               },
//                             ),
//
//                             SizedBox(height: Get.height * 0.01),
//                             //Additional Note For Supplier
//                             AppWidgets.commonUI(
//                               isShowWidget: true,
//                               widthHeading: Get.width,
//                               title: "Additional Note",
//                               widget: Container(
//                                 decoration: const BoxDecoration(color: AppColors.lightblue),
//                                 child: AppWidgets.quoteFieldsC(textEditingController: noteController, maxLine: 4),
//                               ),
//                             ),
//                             SizedBox(height: Get.height * 0.01),
//
//                             AppWidgets.uploadImageButton(
//                               onTap: () async => purchaseController.imagePickerDialogue(context),
//                             ),
//
//                             Obx(() {
//                               return purchaseController.selectedImages.isNotEmpty
//                                   ? Container(
//                                       width: Get.width,
//                                       margin: const EdgeInsets.symmetric(horizontal: 8),
//                                       decoration: const BoxDecoration(color: AppColors.lightblue),
//                                       height: 120,
//                                       child: ValueListenableBuilder(
//                                         valueListenable: purchaseController.refreshImagesChange,
//                                         builder: (context, value, child) {
//                                           return ListView.builder(
//                                             shrinkWrap: true,
//                                             scrollDirection: Axis.horizontal,
//                                             itemCount: purchaseController.selectedImages.length,
//                                             itemBuilder: (context, index) {
//                                               return Padding(
//                                                 padding: const EdgeInsets.all(8.0),
//                                                 child: InkWell(
//                                                   onTap: () => AppWidgets.singleImageDialogue(image: purchaseController.selectedImages[index]),
//                                                   child: Stack(
//                                                     children: [
//                                                       SizedBox(
//                                                         height: 100,
//                                                         width: 70,
//                                                         child: Image.file(File(purchaseController.selectedImages[index].path), fit: BoxFit.cover),
//                                                       ),
//                                                       Positioned(
//                                                         top: 0,
//                                                         right: 0,
//                                                         child: InkWell(
//                                                           onTap: () {
//                                                             purchaseController.selectedImages.removeAt(index);
//                                                             purchaseController.refreshImagesChange.value = Random().nextInt(9999999);
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
//
//                             SizedBox(height: Get.height * 0.015),
//                             //Total Container
//                             if (widget.isEdit)
//                               Obx(() {
//                                 return AppWidgets.totalContainer(
//                                   subtotal: "SubTotal",
//                                   subtotal1: "£ ${categoryProductController.subtotal.value.toStringAsFixed(2)}",
//                                   vat: "VAT(20%)",
//                                   vat1: "£ ${categoryProductController.vat.value.toStringAsFixed(2)}",
//                                   grandTotal: "Grand Total",
//                                   grandTotal1: "£ ${categoryProductController.grandTotal.value.toStringAsFixed(2)}",
//                                 );
//                               }),
//                             if (!widget.isEdit)
//                               Container(
//                                 padding: const EdgeInsets.all(2),
//                                 margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                                 decoration: const BoxDecoration(color: AppColors.white),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       flex: 2,
//                                       child: AppWidgets.snText(
//                                         textAlign: TextAlign.end,
//                                         text: "Total Estimated  Amount",
//                                         style: AppFonts.white18.copyWith(
//                                           fontWeight: FontWeight.w500,
//                                           letterSpacing: 0,
//                                           fontSize: 15.sp,
//                                           color: AppColors.lightblue,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Expanded(
//                                       flex: 1,
//                                       child: Container(
//                                         padding: const EdgeInsets.all(2.0),
//                                         decoration: const BoxDecoration(color: AppColors.lightblue),
//                                         child: TextFormField(
//                                           controller: estimatedAmount,
//                                           cursorColor: AppColors.white,
//                                           maxLines: 1,
//                                           keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsets.zero,
//                                             border: InputBorder.none,
//                                             prefixText: " £ ",
//                                             prefixStyle: AppFonts.white18.copyWith(
//                                               fontWeight: FontWeight.w500,
//                                               letterSpacing: 0,
//                                               fontSize: 20.sp,
//                                               color: AppColors.white,
//                                             ),
//                                           ),
//                                           style: AppFonts.white18.copyWith(
//                                             fontWeight: FontWeight.w500,
//                                             letterSpacing: 0,
//                                             fontSize: 20.sp,
//                                             color: AppColors.white,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             SizedBox(height: Get.height * 0.02),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//         bottomNavigationBar: InkWell(
//           onTap: () async {
//             String uid = await HiveDB.getData(AppStrings.UID);
//             void addPurchaseOrderListApi(Map<String, dynamic> data) async {
//               for (var i = 0; i < plantProduct.length; i++) {
//                 data['PLANT_ITEM[$i]'] = plantProduct[i].productId;
//                 data['PLANT_QTY[$i]'] = plantProduct[i].qty;
//                 data['PLANT_PRICE[$i]'] = plantProduct[i].itemPrice;
//                 data['PLANT_AMOUNT[$i]'] = plantProduct[i].itemTotalPrice;
//               }
//               for (var i = 0; i < materialProduct.length; i++) {
//                 data['ITEM[$i]'] = materialProduct[i].itemID;
//                 data['QTY[$i]'] = materialProduct[i].qty;
//                 data['PART_NO[$i]'] = materialProduct[i].partNO ?? "";
//                 data['UNITPRICE[$i]'] = materialProduct[i].itemPrice;
//                 data['AMOUNT[$i]'] = materialProduct[i].itemTotalPrice;
//                 data['EMS_CODE[$i]'] = materialProduct[i].emsCode;
//               }
//               for (var i = 0; i < accessProduct.length; i++) {
//                 data['AE_ITEM[$i]'] = accessProduct[i].itemID;
//                 data['AE_QTY[$i]'] = accessProduct[i].qty;
//                 data['AE_PRICE[$i]'] = accessProduct[i].itemPrice;
//                 data['AE_AMOUNT[$i]'] = accessProduct[i].itemTotalPrice;
//               }
//             }
//
//             //For Add Edit Request Purchase Order
//             if (!widget.isEdit) {
//               if (purchaseController.poNumber.value.isEmpty) {
//                 AppWidgets.toast(msg: "Please Select Project", backgroundColor: AppColors.red);
//                 return;
//               }
//               if (estimatedAmount.text.isEmpty) {
//                 AppWidgets.toast(msg: "Please Enter Estimated Amount", backgroundColor: AppColors.red);
//                 return;
//               }
//               Map<String, dynamic> data = {};
//               data.addAll({
//                 "USER_ID": uid,
//                 "PO_NUMBER": purchaseController.poNumber.value,
//                 "JOB_ID": category.value,
//                 "SUPPLIER_ID": supplierID,
//                 "CUSTOM_SUPPLIER_NAME": customSupplier,
//                 "ADDITIONAL_NOTES": noteController.text,
//                 "PO_DATE": apiDate2,
//                 "TOTAL_AMOUNT": estimatedAmount.text,
//               });
//
//               if (widget.title == "Edit Request Purchase Order") {
//                 data.addAll({"PO_ID": widget.poId});
//               }
//
//               addPurchaseOrderListApi(data);
//
//               await purchaseController.addPurchaseOrderWithFiles(data: data, selectedImages: purchaseController.selectedImages);
//             }
//
//             //For Add Edit Purchase Order
//             else {
//               Map<String, dynamic> data = {};
//               data.addAll({
//                 "DELIVERY_TYPE": deliveryType.value,
//                 "PO_ID": widget.poId,
//                 "USER_ID": uid,
//                 "PO_NUMBER": purchaseController.poNumber.value,
//                 "JOB_ID": category.value,
//                 "SUPPLIER_ID": supplierID,
//                 "CUSTOM_SUPPLIER_NAME": customSupplier,
//                 "REFERANCE_NUMBER": referenceController.text,
//                 "ADDITIONAL_NOTES": noteController.text,
//                 "FULL_DELIVERY_ADDRESS": addressController.text,
//                 "PLANT_VAT_AMOUNT": categoryProductController.plantVAT.value.toString(),
//                 "MATERIAL_VAT_AMOUNT": categoryProductController.materialVAT.value.toString(),
//                 "ACCESS_EQUIPMENT_VAT_AMOUNT": categoryProductController.accessVAT.value.toString(),
//                 "PO_DATE": apiDate,
//                 "EXP_DELIVERY_DATE": apiDate2,
//                 "SUB_TOTAL": categoryProductController.subtotal.value.toString(),
//                 "TOTAL_VAT_AMOUNT": categoryProductController.vat.value.toString(),
//                 "TOTAL_AMOUNT": categoryProductController.grandTotal.value.toString(),
//               });
//
//               addPurchaseOrderListApi(data);
//
//               for (var i = 0; i < purchaseController.selectedContacts.length; i++) {
//                 data['SUPPLIER_CONTACT[$i]'] = purchaseController.selectedContacts[i].id;
//               }
//
//               await purchaseController.addPurchaseOrderWithFiles(data: data, selectedImages: purchaseController.selectedImages);
//             }
//           },
//           child: Container(
//             height: 8.5.h,
//             width: Get.width,
//             decoration: BoxDecoration(color: AppColors.green, borderRadius: BorderRadius.circular(0)),
//             child: Center(
//               child: AppWidgets.snText(
//                 text: widget.title == "Edit Purchase Order" || widget.title == "Edit Request Purchase Order" ? "Update Purchase Order" : "Request Purchase Order",
//                 style: AppFonts.white18.copyWith(fontWeight: FontWeight.bold, letterSpacing: 0, fontSize: 16.sp),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void clearDialogueValues() {
//     rootCatShow.value = true;
//     subCatShow.value = false;
//     productShow.value = false;
//     searchProductShow.value = false;
//     rootCatName = '';
//     subCatName = '';
//     selectIndex.value = -1;
//     subCategoryList.clear();
//     listChange.value = Random().nextInt(9999999);
//     categoryProductController.totalPrice.value = 0.0;
//     categoryProductController.counter.value = 0;
//     categoryProductController.unitPrice.value = 0.0;
//     categoryProductController.unitPriceController.text = '0.0';
//     purchaseController.searchFieldController.clear();
//     purchaseController.searchProductValue.value = '';
//     FocusScope.of(context).unfocus();
//   }
//
//   Future<dynamic> accessEquipmentEditQtyDialogue(BuildContext context, int index) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//           child: AlertDialog(
//             titlePadding: EdgeInsets.zero,
//             actionsPadding: EdgeInsets.zero,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
//             backgroundColor: AppColors.white,
//             surfaceTintColor: AppColors.white,
//             insetPadding: const EdgeInsets.symmetric(horizontal: 20),
//             title: Container(
//               decoration: const BoxDecoration(color: AppColors.lightblue),
//               padding: const EdgeInsets.all(10),
//               child: Center(
//                 child: AppWidgets.snText(
//                   text: "Update Quantity",
//                   style: AppFonts.white18.copyWith(fontWeight: FontWeight.bold, fontSize: 16.sp),
//                 ),
//               ),
//             ),
//             content: Obx(() {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   AppWidgets.incDec(
//                     onDec: () {
//                       categoryProductController.decrement();
//                       categoryProductController.calculatePrices();
//                     },
//                     onInc: () {
//                       categoryProductController.increment();
//                       categoryProductController.calculatePrices();
//                     },
//                     value: "${categoryProductController.counter.value}",
//                   ),
//                   const SizedBox(height: 10),
//                   TextFormField(
//                     controller: categoryProductController.unitPriceController,
//                     keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                     decoration: const InputDecoration(
//                       labelText: 'Unit Price',
//                       border: OutlineInputBorder(),
//                     ),
//                     onChanged: (value) {
//                       if (value.isEmpty) {
//                         // deliveryController.textEditingController1.text = '0.0';
//                       } else {
//                         categoryProductController.calculatePrices();
//                       }
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Total Price: ${categoryProductController.totalPrice.value.toStringAsFixed(2)}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                 ],
//               );
//             }),
//             actions: [
//               AppWidgets.addRemoveButton(
//                 onAdd: () {
//                   setState(() {
//                     accessProduct[index] = PurchaseProductModel(
//                       items: accessProduct[index].items,
//                       qty: categoryProductController.counter.value.toString(),
//                       itemID: accessProduct[index].itemID,
//                       itemPrice: categoryProductController.unitPriceController.text,
//                       itemTotalPrice: categoryProductController.totalPrice.value.toString(),
//                       productId: accessProduct[index].productId,
//                     );
//                   });
//                   categoryProductController.calculateTotals(plantProduct, materialProduct, accessProduct);
//                   categoryProductController.isVisible3.value = true;
//                   listChange.value = Random().nextInt(9999999);
//                   FocusScope.of(context).unfocus();
//                   Get.back();
//                 },
//                 onRemove: () {
//                   accessProduct.removeAt(index);
//                   categoryProductController.calculateTotals(plantProduct, materialProduct, accessProduct);
//                   listChange.value = Random().nextInt(9999999);
//                   FocusScope.of(context).unfocus();
//                   Get.back();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<dynamic> materialEditQtyDialogue(BuildContext context, int index) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//           child: AlertDialog(
//             insetPadding: const EdgeInsets.all(20),
//             backgroundColor: AppColors.white,
//             surfaceTintColor: AppColors.white,
//             titlePadding: EdgeInsets.zero,
//             actionsPadding: EdgeInsets.zero,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(0),
//             ),
//             title: Container(
//               padding: const EdgeInsets.all(10),
//               decoration: const BoxDecoration(
//                 color: AppColors.lightblue,
//               ),
//               child: Center(
//                 child: AppWidgets.snText(
//                   text: "Update Quantity",
//                   style: AppFonts.white18.copyWith(fontWeight: FontWeight.bold, fontSize: 16.sp),
//                 ),
//               ),
//             ),
//             content: Obx(() {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   AppWidgets.incDec(
//                     onDec: () {
//                       categoryProductController.decrement();
//                       categoryProductController.calculatePrices();
//                     },
//                     onInc: () {
//                       categoryProductController.increment();
//                       categoryProductController.calculatePrices();
//                     },
//                     value: "${categoryProductController.counter.value}",
//                   ),
//                   const SizedBox(height: 10),
//                   TextFormField(
//                     controller: categoryProductController.unitPriceController,
//                     keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                     decoration: const InputDecoration(labelText: 'Unit Price', border: OutlineInputBorder()),
//                     onChanged: (value) {
//                       if (value.isEmpty) {
//                         // deliveryController.textEditingController1.text = '0.0';
//                       } else {
//                         categoryProductController.calculatePrices();
//                       }
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Total Price: ${categoryProductController.totalPrice.value.toStringAsFixed(2)}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                 ],
//               );
//             }),
//             actions: [
//               AppWidgets.addRemoveButton(
//                 onAdd: () {
//                   setState(() {
//                     materialProduct[index] = PurchaseProductModel(
//                       items: materialProduct[index].items,
//                       qty: categoryProductController.counter.value.toString(),
//                       itemID: materialProduct[index].itemID,
//                       itemPrice: categoryProductController.unitPriceController.text,
//                       itemTotalPrice: categoryProductController.totalPrice.value.toString(),
//                       productId: materialProduct[index].productId,
//                       emsCode: materialProduct[index].emsCode,
//                       itemName: materialProduct[index].itemName,
//                       partNO: "",
//                       rootName: materialProduct[index].rootName,
//                     );
//                     categoryProductController.calculateTotals(plantProduct, materialProduct, accessProduct);
//                     categoryProductController.isVisible2.value = true;
//                     listChange.value = Random().nextInt(9999999);
//                     FocusScope.of(context).unfocus();
//                     Navigator.pop(context);
//                   });
//                 },
//                 onRemove: () {
//                   materialProduct.removeAt(index);
//                   categoryProductController.calculateTotals(plantProduct, materialProduct, accessProduct);
//                   categoryProductController.isVisible2.value = true;
//                   listChange.value = Random().nextInt(9999999);
//                   FocusScope.of(context).unfocus();
//                   Get.back();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<dynamic> planToolEditQtyDialogue(BuildContext context, int index) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//           child: AlertDialog(
//             insetPadding: const EdgeInsets.all(20),
//             backgroundColor: AppColors.white,
//             surfaceTintColor: AppColors.white,
//             titlePadding: EdgeInsets.zero,
//             actionsPadding: EdgeInsets.zero,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
//             title: Container(
//               padding: const EdgeInsets.all(10),
//               decoration: const BoxDecoration(color: AppColors.lightblue),
//               child: Center(
//                 child: AppWidgets.snText(
//                   text: "Update Quantity",
//                   style: AppFonts.white18.copyWith(fontWeight: FontWeight.bold, fontSize: 16.sp),
//                 ),
//               ),
//             ),
//             content: Obx(() {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   AppWidgets.incDec(
//                     onDec: () {
//                       categoryProductController.decrement();
//                       categoryProductController.calculatePrices();
//                     },
//                     onInc: () {
//                       categoryProductController.increment();
//                       categoryProductController.calculatePrices();
//                     },
//                     value: "${categoryProductController.counter.value}",
//                   ),
//                   const SizedBox(height: 10),
//                   TextFormField(
//                     controller: categoryProductController.unitPriceController,
//                     keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                     decoration: const InputDecoration(labelText: 'Unit Price', border: OutlineInputBorder()),
//                     onChanged: (value) => categoryProductController.calculatePrices(),
//                     onEditingComplete: () {
//                       // Check if the input is empty or contains only non-numeric characters
//                       if (categoryProductController.unitPriceController.text.isEmpty || double.tryParse(categoryProductController.unitPriceController.text) == null) {
//                         // If empty or invalid, set the text to '0.0'
//                         categoryProductController.unitPriceController.text = '0.0';
//                         categoryProductController.calculatePrices(); // Recalculate after setting to 0.0
//                       }
//                     },
//                     inputFormatters: [
//                       FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Total Price: ${categoryProductController.totalPrice.value.toStringAsFixed(2)}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                 ],
//               );
//             }),
//             actions: [
//               AppWidgets.addRemoveButton(
//                 onAdd: () {
//                   // Ensure the text is set to '0.0' if empty
//                   if (categoryProductController.unitPriceController.text.isEmpty || double.tryParse(categoryProductController.unitPriceController.text) == null) {
//                     categoryProductController.unitPriceController.text = '0.0';
//                   }
//                   setState(() {
//                     plantProduct[index] = PurchaseProductModel(
//                       items: plantProduct[index].items,
//                       qty: categoryProductController.counter.value.toString(),
//                       itemID: plantProduct[index].itemID,
//                       itemPrice: categoryProductController.unitPriceController.text,
//                       itemTotalPrice: categoryProductController.totalPrice.value.toString(),
//                       productId: plantProduct[index].productId,
//                       rootName: plantProduct[index].rootName,
//                     );
//                     categoryProductController.counter.value = 0;
//                     categoryProductController.calculateTotals(plantProduct, materialProduct, accessProduct);
//                     categoryProductController.unitPriceController.text = '0.0';
//                     FocusScope.of(context).unfocus();
//                     Navigator.pop(context);
//                   });
//                 },
//                 onRemove: () {
//                   setState(() {
//                     plantProduct.removeAt(index);
//                     categoryProductController.calculateTotals(plantProduct, materialProduct, accessProduct);
//                     FocusScope.of(context).unfocus();
//                     Navigator.pop(context);
//                   });
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<dynamic> selectSupplierContactDialogue(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         var contactList = purchaseController.getContactDetailsBySupplierId(supplierID);
//         bool hasContacts = contactList.isNotEmpty;
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           content: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               return SizedBox(
//                 height: Get.height * 0.5,
//                 width: Get.width * 0.8,
//                 child: Column(
//                   children: [
//                     Text(
//                       "Select Supplier Contact",
//                       style: AppFonts.black16.copyWith(fontWeight: FontWeight.bold),
//                     ),
//                     Expanded(
//                       child: hasContacts
//                           ? ListView.builder(
//                               itemCount: contactList.length,
//                               itemBuilder: (context, index) {
//                                 var contact = contactList[index];
//                                 bool isChecked = purchaseController.selectedContacts.any((selected) => selected.id == contact["ID"]);
//                                 return ListTile(
//                                   title: Text(
//                                     "${contact["NAME"]}",
//                                     style: AppFonts.black14.copyWith(fontWeight: FontWeight.bold),
//                                   ),
//                                   trailing: Checkbox(
//                                     value: isChecked,
//                                     onChanged: (bool? value) {
//                                       setState(() {
//                                         if (value == true) {
//                                           purchaseController.selectedContacts.add(ContactEmail(id: contact["ID"], name: contact["NAME"], email: contact["EMAIL"]));
//                                         } else {
//                                           purchaseController.selectedContacts.removeWhere((selected) => selected.id == contact["ID"]);
//                                         }
//                                       });
//                                     },
//                                   ),
//                                   onTap: () {
//                                     setState(() {
//                                       if (isChecked) {
//                                         purchaseController.selectedContacts.removeWhere((selected) => selected.id == contact["ID"]);
//                                       } else {
//                                         purchaseController.selectedContacts.add(ContactEmail(id: contact["ID"], name: contact["NAME"], email: contact["EMAIL"]));
//                                       }
//                                     });
//                                   },
//                                 );
//                               },
//                             )
//                           : Center(
//                               child: Text(
//                                 "No contacts available",
//                                 style: AppFonts.black14.copyWith(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                     ),
//                     TextButton(
//                       onPressed: () => Navigator.of(context).pop(),
//                       child: const Text("Close"),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
//
//   Future<dynamic> selectSupplierSheet(BuildContext context) {
//     return showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return Container(
//               height: Get.height * 0.6,
//               decoration: const BoxDecoration(color: AppColors.white),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         AppWidgets.snText(
//                           text: "Type your own supplier:",
//                           style: AppFonts.black14.copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp),
//                         ),
//                         const SizedBox(height: 10.0),
//                         TextField(
//                           controller: customSupplierController,
//                           decoration: InputDecoration(
//                             hintText: "Enter supplier name",
//                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
//                           ),
//                         ),
//                         const SizedBox(height: 8.0),
//                         TextButton(
//                           style: TextButton.styleFrom(backgroundColor: AppColors.green),
//                           onPressed: () {
//                             setState(() {
//                               if (customSupplierController.text.isNotEmpty) {
//                                 selectedSupplier = customSupplierController.text;
//                                 supplierID = "0";
//                                 customSupplier = customSupplierController.text;
//                                 purchaseController.refreshScreen.value = Random().nextInt(9999999);
//                               }
//                             });
//                             Navigator.of(context).pop();
//                           },
//                           child: AppWidgets.snText(text: "Add Supplier", style: AppFonts.white14.copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp)),
//                         ),
//                         const Divider(),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: purchaseController.poSiteList.length,
//                       itemBuilder: (context, index) {
//                         var poSite = purchaseController.poSiteList[index];
//                         return ListTile(
//                           title: AppWidgets.snText(
//                             text: '${poSite.supplierName} ',
//                             style: AppFonts.black14.copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp),
//                           ),
//                           onTap: () {
//                             setState(() {
//                               selectedSupplier = poSite.supplierName!;
//                               supplierID = poSite.supplierId!;
//                               purchaseController.refreshScreen.value = Random().nextInt(9999999);
//                               purchaseController.selectedContacts = <ContactEmail>[].obs;
//                             });
//                             Navigator.of(context).pop();
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Future<dynamic> addAccessEquipmentDialogue(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return ValueListenableBuilder(
//           valueListenable: listChange,
//           builder: (context, value, child) {
//             return BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//               child: Dialog(
//                 insetPadding: const EdgeInsets.all(20),
//                 backgroundColor: AppColors.white,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
//                 child: SizedBox(
//                   child: Obx(() {
//                     return Column(
//                       children: [
//                         Container(
//                           decoration: const BoxDecoration(color: AppColors.lightblue),
//                           child: AppBar(
//                             backgroundColor: AppColors.lightblue,
//                             leading: IconButton(
//                               onPressed: () => Get.back(),
//                               icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
//                             ),
//                             title: AppWidgets.customText(
//                               text: 'Select Access Equipment',
//                               style: AppFonts.white18.copyWith(fontWeight: FontWeight.bold, fontSize: 18.sp),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                           decoration: BoxDecoration(color: AppColors.darkBlue.withValues(alpha: 0.6)),
//                           child: AppWidgets.searchTextFeild(
//                             onChanged: (value) => purchaseController.searchProductValue.value = value,
//                             onTap: () {
//                               searchProductShow.value = true;
//                               rootCatShow.value = false;
//                               subCatShow.value = false;
//                               productShow.value = false;
//                               rootCatName = '';
//                               subCatName = '';
//                               selectIndex.value = -1;
//                               subCategoryList.clear();
//                               listChange.value = Random().nextInt(9999999);
//                             },
//                             controller: purchaseController.searchFieldController,
//                             suffixIcon: Visibility(
//                               visible: searchProductShow.value,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: CircleAvatar(
//                                   backgroundColor: AppColors.red,
//                                   child: IconButton(
//                                     onPressed: () {
//                                       purchaseController.searchProductValue.value = '';
//                                       purchaseController.searchFieldController.clear();
//                                       rootCatShow.value = true;
//                                       subCatShow.value = false;
//                                       productShow.value = false;
//                                       searchProductShow.value = false;
//                                       rootCatName = '';
//                                       subCatName = '';
//                                       selectIndex.value = -1;
//                                       subCategoryList.clear();
//                                       FocusScope.of(context).unfocus();
//                                       listChange.value = Random().nextInt(9999999);
//                                     },
//                                     icon: const Icon(Icons.close, color: AppColors.white),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         if (rootCatName.isNotEmpty)
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
//                             child: SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: SizedBox(
//                                 width: Get.width,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         rootCatShow.value = true;
//                                         subCatShow.value = false;
//                                         productShow.value = false;
//                                         rootCatName = '';
//                                         subCatName = '';
//                                         purchaseController.searchFieldController.clear();
//                                         purchaseController.searchProductValue.value = '';
//                                         FocusScope.of(context).unfocus();
//                                         subCategoryList.clear();
//                                         listChange.value = Random().nextInt(9999999);
//                                       },
//                                       child: AppWidgets.customText(
//                                         text: rootCatName,
//                                         style: AppFonts.lightBlueColor14,
//                                       ),
//                                     ),
//                                     const Padding(
//                                       padding: EdgeInsets.symmetric(
//                                         horizontal: 3.0,
//                                       ),
//                                       child: Icon(
//                                         Icons.arrow_forward_ios,
//                                         size: 18,
//                                         color: AppColors.lightblue,
//                                       ),
//                                     ),
//                                     if (subCatName.isNotEmpty)
//                                       InkWell(
//                                           onTap: () {
//                                             rootCatShow.value = false;
//                                             subCatShow.value = true;
//                                             productShow.value = false;
//                                             subCatName = '';
//                                             purchaseController.searchFieldController.clear();
//                                             purchaseController.searchProductValue.value = '';
//                                             FocusScope.of(context).unfocus();
//                                             productList.clear();
//                                             listChange.value = Random().nextInt(9999999);
//                                           },
//                                           child: AppWidgets.customText(text: subCatName, style: AppFonts.lightBlueColor14)),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         if (rootCatShow.value)
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: ValueListenableBuilder(
//                                 valueListenable: purchaseController.searchProductValue,
//                                 builder: (context, String search, child) {
//                                   return DynamicHeightGridView(
//                                     crossAxisCount: 3,
//                                     crossAxisSpacing: 5,
//                                     mainAxisSpacing: 5,
//                                     itemCount: categoryController.selectedPlant?.aeRootCategories?.where((category) => search.isEmpty || (category.rootName?.toLowerCase().contains(search.toLowerCase()) ?? false)).length ?? 0,
//                                     builder: (context, index) {
//                                       var filteredCategories = categoryController.selectedPlant?.aeRootCategories?.where((category) => search.isEmpty || (category.rootName?.toLowerCase().contains(search.toLowerCase()) ?? false)).toList() ?? [];
//                                       var category = filteredCategories[index];
//                                       return AppWidgets.gridView(
//                                         onTap: () {
//                                           rootCatName = '${category.rootName}';
//                                           rootCatShow.value = false;
//                                           subCatShow.value = false;
//                                           productShow.value = true;
//                                           purchaseController.searchFieldController.clear();
//                                           purchaseController.searchProductValue.value = '';
//                                           FocusScope.of(context).unfocus();
//                                           var selectedRootId = category.rootId;
//                                           productList2.clear();
//                                           for (var product in categoryController.selectedPlant?.aeProducts ?? []) {
//                                             if (product.rootId == selectedRootId) {
//                                               productList2.add(product);
//                                             }
//                                           }
//
//                                           listChange.value = Random().nextInt(9999999);
//                                         },
//                                         color: AppColors.lightblue,
//                                         title: '${category.rootName}',
//                                       );
//                                     },
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         // if (subCatShow.value)
//                         //   Expanded(
//                         //       child: Padding(
//                         //     padding: const EdgeInsets.all(8.0),
//                         //     child: DynamicHeightGridView(
//                         //       crossAxisCount: 3,
//                         //       mainAxisSpacing: 5,
//                         //       crossAxisSpacing: 5,
//                         //       itemCount:
//                         //           subCategoryList
//                         //               .length,
//                         //       builder:
//                         //           (context, index) {
//                         //         return CommonWidgets
//                         //             .gridView(
//                         //           onTap: () {
//                         //             subCatName =
//                         //                 '${subCategoryList[index].subName}';
//                         //             rootCatShow
//                         //                     .value =
//                         //                 false;
//                         //             subCatShow
//                         //                     .value =
//                         //                 false;
//                         //             productShow
//                         //                     .value =
//                         //                 true;
//                         //             // if (subCategoryList[index].subName!.isNotEmpty) {
//                         //             //   productList.clear();
//                         //             //
//                         //             //   for (var i in subCategoryList[index]
//                         //             //       .subName) {
//                         //             //     productList
//                         //             //         .add(i);
//                         //             //   }
//                         //             // }
//                         //             listChange
//                         //                     .value =
//                         //                 Random().nextInt(
//                         //                     9999999);
//                         //           },
//                         //           color:
//                         //               CC.lightblue,
//                         //           title:
//                         //               '${subCategoryList[index].subName}',
//                         //         );
//                         //       },
//                         //     ),
//                         //   )),
//                         if (productShow.value)
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ValueListenableBuilder(
//                                 valueListenable: purchaseController.searchProductValue,
//                                 builder: (context, String search, child) {
//                                   return DynamicHeightGridView(
//                                     crossAxisCount: 3,
//                                     mainAxisSpacing: 5,
//                                     crossAxisSpacing: 5,
//                                     itemCount: productList2.where((product) => search.isEmpty || (product.productName?.toLowerCase().contains(search.toLowerCase()) ?? false)).length,
//                                     builder: (context, index) {
//                                       var filteredProducts = productList2.where((product) => search.isEmpty || (product.productName?.toLowerCase().contains(search.toLowerCase()) ?? false)).toList();
//                                       var product = filteredProducts[index];
//                                       return Obx(
//                                         () {
//                                           return AppWidgets.gridView(
//                                             onTap: () {
//                                               selectIndex.value = index;
//                                               plantName.value = product.productName ?? "";
//                                             },
//                                             color: selectIndex.value == index ? AppColors.green : AppColors.lightblue,
//                                             title: '${product.productName}',
//                                           );
//                                         },
//                                       );
//                                     },
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         if (searchProductShow.value)
//                           Builder(builder: (context) {
//                             productList2.clear();
//                             for (var product in categoryController.selectedPlant?.aeProducts ?? []) {
//                               productList2.add(product);
//                             }
//                             return Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: ValueListenableBuilder(
//                                   valueListenable: purchaseController.searchProductValue,
//                                   builder: (context, String search, child) {
//                                     var filteredProducts = productList2.where((product) => search.isEmpty || (product.productName?.toLowerCase().contains(search.toLowerCase()) ?? false)).toList();
//
//                                     if (filteredProducts.isEmpty) {
//                                       return Center(
//                                         child: Text(
//                                           "No products found",
//                                           style: AppFonts.black14.copyWith(
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       );
//                                     }
//
//                                     return DynamicHeightGridView(
//                                       crossAxisCount: 3,
//                                       mainAxisSpacing: 5,
//                                       crossAxisSpacing: 5,
//                                       itemCount: productList2.where((product) => search.isEmpty || (product.productName?.toLowerCase().contains(search.toLowerCase()) ?? false)).length,
//                                       builder: (context, index) {
//                                         var product = filteredProducts[index];
//                                         return Obx(
//                                           () {
//                                             return AppWidgets.gridView(
//                                               onTap: () {
//                                                 selectIndex.value = index;
//                                                 plantName.value = product.productName ?? "";
//                                               },
//                                               color: selectIndex.value == index ? AppColors.green : AppColors.lightblue,
//                                               title: '${product.productName}',
//                                             );
//                                           },
//                                         );
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                             );
//                           }),
//                         Obx(() {
//                           return AppWidgets.incDec(
//                             onDec: () => categoryProductController.decrement(),
//                             onInc: () => categoryProductController.increment(),
//                             value: "${categoryProductController.counter.value}",
//                           );
//                         }),
//                         AppWidgets.unitDis(
//                           ctr: categoryProductController.unitPriceController,
//                           onSubmitted1: (value) {
//                             categoryProductController.unitPriceController.text = value;
//                             categoryProductController.calculatePrices();
//                           },
//                         ),
//                         Obx(() => Text('Total Price: ${categoryProductController.totalPrice.value.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20))),
//                         AppWidgets.addRemoveButton(
//                           onAdd: () {
//                             if (selectIndex.value == -1) {
//                               AppWidgets.toast(msg: "Please select an item");
//                               return;
//                             }
//                             if (accessProduct.any((element) => element.itemID == productList2[selectIndex.value].id)) {
//                               AppWidgets.toast(msg: "This item is already added");
//                               return;
//                             } else {
//                               accessProduct.add(
//                                 PurchaseProductModel(
//                                   items: plantName.value,
//                                   itemName: productList2[selectIndex.value].productName ?? "",
//                                   itemID: productList2[selectIndex.value].id ?? "0",
//                                   qty: categoryProductController.counter.value.toString(),
//                                   itemPrice: categoryProductController.unitPriceController.text,
//                                   itemTotalPrice: categoryProductController.totalPrice.value.toString(),
//                                   productId: productList2[selectIndex.value].id ?? "0",
//                                 ),
//                               );
//                               rootCatShow.value = true;
//                               subCatShow.value = false;
//                               productShow.value = false;
//                               rootCatName = '';
//                               subCatName = '';
//                               categoryProductController.calculateTotals(plantProduct, materialProduct, accessProduct);
//                               subCategoryList.clear();
//                               listChange.value = Random().nextInt(9999999);
//                               categoryProductController.counter.value = 0;
//                               categoryProductController.totalPrice.value = 0.00;
//                               categoryProductController.unitPriceController.text = '0.0';
//                               categoryProductController.isVisible3.value = true;
//                               listChange.value = Random().nextInt(9999999);
//                               FocusScope.of(context).unfocus();
//                               Get.back();
//                             }
//                           },
//                           onRemove: () {
//                             rootCatShow.value = true;
//                             subCatShow.value = false;
//                             productShow.value = false;
//                             rootCatName = '';
//                             subCatName = '';
//                             subCategoryList.clear();
//                             listChange.value = Random().nextInt(9999999);
//                             categoryProductController.totalPrice.value = 0.0;
//                             categoryProductController.counter.value = 0;
//                             categoryProductController.unitPrice.value = 0.0;
//                             categoryProductController.unitPriceController.text = '0.0';
//                             FocusScope.of(context).unfocus();
//                             Get.back();
//                           },
//                           removeText: "Cancel",
//                         ),
//                       ],
//                     );
//                   }),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Future<dynamic> addMaterialDialogue(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return ValueListenableBuilder(
//           valueListenable: listChange,
//           builder: (context, value, child) {
//             return BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//               child: Dialog(
//                 insetPadding: const EdgeInsets.all(20),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
//                 backgroundColor: AppColors.white,
//                 child: GestureDetector(
//                   onTap: () => categoryProductController.calculatePrices(),
//                   child: SizedBox(
//                     height: Get.height * 1,
//                     width: Get.width,
//                     child: Obx(() {
//                       return Column(
//                         children: [
//                           Container(
//                             decoration: const BoxDecoration(color: AppColors.lightblue),
//                             child: AppBar(
//                               centerTitle: false,
//                               backgroundColor: AppColors.lightblue,
//                               leading: IconButton(
//                                 onPressed: () => Get.back(),
//                                 icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
//                               ),
//                               title: AppWidgets.customText(
//                                 text: 'Select Materials',
//                                 style: AppFonts.white18.copyWith(fontWeight: FontWeight.bold, fontSize: 18.sp),
//                               ),
//                               actions: [
//                                 //create manual material
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                                   child: ElevatedButton(
//                                     style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//                                     onPressed: () {
//                                       purchaseController.addManualMaterialFieldController.clear();
//                                       Get.back();
//                                       showDialog(
//                                         context: context,
//                                         builder: (context) {
//                                           return BackdropFilter(
//                                             filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                                             child: AlertDialog(
//                                               contentPadding: const EdgeInsets.all(20),
//                                               iconPadding: const EdgeInsets.all(0),
//                                               actionsPadding: const EdgeInsets.all(0),
//                                               insetPadding: const EdgeInsets.all(25),
//                                               titlePadding: const EdgeInsets.all(0),
//                                               backgroundColor: AppColors.white.withValues(alpha: .9),
//                                               surfaceTintColor: AppColors.white.withValues(alpha: .9),
//                                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0), side: const BorderSide(color: AppColors.white, width: 1.5)),
//                                               title: Container(
//                                                 width: Get.width,
//                                                 decoration: const BoxDecoration(color: AppColors.lightblue),
//                                                 alignment: Alignment.center,
//                                                 child: AppBar(
//                                                   backgroundColor: AppColors.lightblue,
//                                                   leading: const SizedBox(),
//                                                   title: AppWidgets.snText(
//                                                     text: 'Add Manual Material',
//                                                     style: AppFonts.white18.copyWith(fontWeight: FontWeight.bold, fontSize: 16.sp),
//                                                   ),
//                                                   centerTitle: true,
//                                                 ),
//                                               ),
//                                               content: Column(
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 children: [
//                                                   TextField(
//                                                     cursorColor: AppColors.lightblue,
//                                                     controller: purchaseController.addManualMaterialFieldController,
//                                                     decoration: const InputDecoration(
//                                                       labelText: 'Enter Material Name',
//                                                       border: OutlineInputBorder(
//                                                         borderSide: BorderSide(color: AppColors.lightblue),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   const SizedBox(height: 15),
//                                                   Obx(() {
//                                                     return AppWidgets.incDec(
//                                                       onDec: () => categoryProductController.decrement(),
//                                                       onInc: () => categoryProductController.increment(),
//                                                       value: "${categoryProductController.counter.value}",
//                                                     );
//                                                   }),
//                                                   const SizedBox(height: 5),
//                                                   AppWidgets.unitDis(
//                                                     ctr: categoryProductController.unitPriceController,
//                                                     onSubmitted1: (value) {
//                                                       categoryProductController.unitPriceController.text = value;
//                                                       categoryProductController.calculatePrices();
//                                                     },
//                                                   ),
//                                                   const SizedBox(height: 10),
//                                                   Obx(() {
//                                                     return Text(
//                                                       'Total Price: ${categoryProductController.totalPrice.value.toStringAsFixed(2)}',
//                                                       style: const TextStyle(fontSize: 16),
//                                                     );
//                                                   }),
//                                                   const SizedBox(height: 10),
//                                                   Row(
//                                                     children: [
//                                                       Expanded(
//                                                         child: ElevatedButton(
//                                                           style: ElevatedButton.styleFrom(backgroundColor: AppColors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
//                                                           onPressed: () => Get.back(),
//                                                           child: AppWidgets.snText(text: "Cancel", style: AppFonts.white16.copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp)),
//                                                         ),
//                                                       ),
//                                                       Expanded(
//                                                         child: ElevatedButton(
//                                                           onPressed: () {
//                                                             if (purchaseController.addManualMaterialFieldController.text.isNotEmpty && purchaseController.addManualMaterialFieldController.text.isNotEmpty) {
//                                                               materialProduct.add(
//                                                                 PurchaseProductModel(
//                                                                   qty: categoryProductController.counter.value.toString(),
//                                                                   items: purchaseController.addManualMaterialFieldController.text,
//                                                                   itemID: purchaseController.addManualMaterialFieldController.text,
//                                                                   itemPrice: categoryProductController.unitPriceController.text,
//                                                                   itemTotalPrice: categoryProductController.totalPrice.value.toString(),
//                                                                   emsCode: "",
//                                                                   itemName: purchaseController.addManualMaterialFieldController.text,
//                                                                   productId: purchaseController.addManualMaterialFieldController.text,
//                                                                   partNO: "",
//                                                                   rootName: "",
//                                                                 ),
//                                                               );
//                                                               categoryProductController.calculateTotals(plantProduct, materialProduct, accessProduct);
//                                                               listChange.value = Random().nextInt(9999999);
//                                                               categoryProductController.counter.value = 0;
//                                                               categoryProductController.unitPriceController.text = '0.0';
//                                                               categoryProductController.isVisible2.value = true;
//                                                               listChange.value = Random().nextInt(9999999);
//                                                               FocusScope.of(context).unfocus();
//                                                               Get.back();
//                                                             } else {
//                                                               AppWidgets.toast(msg: "Please fill all the fields");
//                                                             }
//                                                           },
//                                                           style: ElevatedButton.styleFrom(
//                                                             shape: RoundedRectangleBorder(
//                                                               borderRadius: BorderRadius.circular(0),
//                                                             ),
//                                                             backgroundColor: AppColors.green,
//                                                           ),
//                                                           child: AppWidgets.snText(
//                                                             text: "Add",
//                                                             style: AppFonts.white16.copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       );
//                                     },
//                                     child: AppWidgets.snText(
//                                       text: "Add New",
//                                       style: AppFonts.white16.copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           //search field
//                           Container(
//                             margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                             decoration: BoxDecoration(
//                               color: AppColors.darkBlue.withValues(alpha: 0.6),
//                             ),
//                             child: AppWidgets.searchTextFeild(
//                               onChanged: (value) {
//                                 purchaseController.searchProductValue.value = value;
//                               },
//                               onTap: () {
//                                 searchProductShow.value = true;
//                                 rootCatShow.value = false;
//                                 subCatShow.value = false;
//                                 productShow.value = false;
//                                 rootCatName = '';
//                                 subCatName = '';
//                                 selectIndex.value = -1;
//                                 subCategoryList.clear();
//                                 listChange.value = Random().nextInt(9999999);
//                               },
//                               controller: purchaseController.searchFieldController,
//                               suffixIcon: Visibility(
//                                 visible: searchProductShow.value,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: CircleAvatar(
//                                     backgroundColor: AppColors.red,
//                                     child: IconButton(
//                                       onPressed: () {
//                                         purchaseController.searchProductValue.value = '';
//                                         purchaseController.searchFieldController.clear();
//                                         rootCatShow.value = true;
//                                         subCatShow.value = false;
//                                         productShow.value = false;
//                                         searchProductShow.value = false;
//                                         rootCatName = '';
//                                         subCatName = '';
//                                         selectIndex.value = -1;
//                                         subCategoryList.clear();
//                                         FocusScope.of(context).unfocus();
//                                         listChange.value = Random().nextInt(9999999);
//                                       },
//                                       icon: const Icon(Icons.close, color: AppColors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           if (rootCatName.isNotEmpty)
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: 5.0,
//                                 horizontal: 20,
//                               ),
//                               child: SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: SizedBox(
//                                   width: Get.width,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       InkWell(
//                                         onTap: () {
//                                           rootCatShow.value = true;
//                                           subCatShow.value = false;
//                                           productShow.value = false;
//                                           rootCatName = '';
//                                           subCatName = '';
//                                           subCategoryList.clear();
//                                           purchaseController.searchFieldController.clear();
//                                           purchaseController.searchProductValue.value = '';
//                                           FocusScope.of(context).unfocus();
//                                           listChange.value = Random().nextInt(9999999);
//                                         },
//                                         child: AppWidgets.customText(
//                                           text: rootCatName,
//                                           style: AppFonts.lightBlueColor14,
//                                         ),
//                                       ),
//                                       const Padding(
//                                         padding: EdgeInsets.symmetric(horizontal: 3.0),
//                                         child: Icon(Icons.arrow_forward_ios, size: 18, color: AppColors.lightblue),
//                                       ),
//                                       if (subCatName.isNotEmpty)
//                                         InkWell(
//                                           onTap: () {
//                                             rootCatShow.value = false;
//                                             subCatShow.value = true;
//                                             productShow.value = false;
//                                             subCatName = '';
//                                             productList.clear();
//                                             purchaseController.searchFieldController.clear();
//                                             purchaseController.searchProductValue.value = '';
//                                             FocusScope.of(context).unfocus();
//                                             listChange.value = Random().nextInt(9999999);
//                                           },
//                                           child: AppWidgets.customText(text: subCatName, style: AppFonts.lightBlueColor14),
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           if (rootCatShow.value)
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: ValueListenableBuilder(
//                                   valueListenable: purchaseController.searchProductValue,
//                                   builder: (context, String search, child) {
//                                     return DynamicHeightGridView(
//                                       crossAxisCount: 3,
//                                       crossAxisSpacing: 5,
//                                       mainAxisSpacing: 5,
//                                       itemCount: categoryController.selectedPlant?.rootCategories?.where((category) => search.isEmpty || (category.rootName?.toLowerCase().contains(search.toLowerCase()) ?? false)).length ?? 0,
//                                       builder: (context, index) {
//                                         var filteredCategories = categoryController.selectedPlant?.rootCategories?.where((category) => search.isEmpty || (category.rootName?.toLowerCase().contains(search.toLowerCase()) ?? false)).toList() ?? [];
//                                         var category = filteredCategories[index];
//                                         return AppWidgets.gridView(
//                                           onTap: () {
//                                             rootCatName = '${category.rootName}';
//                                             rootCatShow.value = false;
//                                             purchaseController.searchFieldController.clear();
//                                             purchaseController.searchProductValue.value = '';
//                                             subCatShow.value = true;
//                                             productShow.value = false;
//                                             var selectedRootId = category.rootId;
//
//                                             purchaseController.searchFieldController.clear();
//                                             purchaseController.searchProductValue.value = '';
//                                             FocusScope.of(context).unfocus();
//
//                                             subCategoryList.clear();
//                                             for (var subCat in categoryController.selectedPlant?.subCategories ?? []) {
//                                               if (subCat.rootId == selectedRootId) {
//                                                 subCategoryList.add(subCat);
//                                               }
//                                             }
//                                             listChange.value = Random().nextInt(9999999);
//                                           },
//                                           color: AppColors.lightblue,
//                                           title: '${category.rootName}',
//                                         );
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           if (subCatShow.value)
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: ValueListenableBuilder(
//                                   valueListenable: purchaseController.searchProductValue,
//                                   builder: (context, String search, child) {
//                                     return DynamicHeightGridView(
//                                       crossAxisCount: 3,
//                                       crossAxisSpacing: 5,
//                                       mainAxisSpacing: 5,
//                                       itemCount: subCategoryList.where((subCat) => search.isEmpty || (subCat.subName?.toLowerCase().contains(search.toLowerCase()) ?? false)).length,
//                                       builder: (context, index) {
//                                         var filteredSubCategories = subCategoryList.where((subCat) => search.isEmpty || (subCat.subName?.toLowerCase().contains(search.toLowerCase()) ?? false)).toList();
//                                         var subCategory = filteredSubCategories[index];
//                                         return AppWidgets.gridView(
//                                           onTap: () {
//                                             subCatName = '${subCategory.subName}';
//                                             rootCatShow.value = false;
//                                             subCatShow.value = false;
//                                             purchaseController.searchFieldController.clear();
//                                             purchaseController.searchProductValue.value = '';
//                                             FocusScope.of(context).unfocus();
//                                             productShow.value = true;
//                                             var selectedSubId = subCategory.subId;
//                                             productList.clear();
//                                             for (var product in categoryController.selectedPlant?.products ?? []) {
//                                               if (product.subId == selectedSubId) {
//                                                 productList.add(product);
//                                               }
//                                             }
//                                             listChange.value = Random().nextInt(9999999);
//                                           },
//                                           color: AppColors.lightblue,
//                                           title: '${subCategory.subName}',
//                                         );
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           if (productShow.value)
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: ValueListenableBuilder(
//                                     valueListenable: purchaseController.searchProductValue,
//                                     builder: (context, String search, child) {
//                                       return DynamicHeightGridView(
//                                         itemCount: productList.where((product) => search.isEmpty || (product.productName?.toLowerCase().contains(search.toLowerCase()) ?? false)).length,
//                                         crossAxisCount: 3,
//                                         crossAxisSpacing: 5,
//                                         mainAxisSpacing: 5,
//                                         builder: (BuildContext context, int index) {
//                                           var filteredProducts = productList.where((product) => search.isEmpty || (product.productName?.toLowerCase().contains(search.toLowerCase()) ?? false)).toList();
//                                           var product = filteredProducts[index];
//                                           return Obx(() {
//                                             return AppWidgets.gridView(
//                                               onTap: () {
//                                                 selectIndex.value = index;
//                                                 plantName.value = product.productName ?? "";
//                                               },
//                                               color: selectIndex.value == index ? AppColors.green : AppColors.lightblue,
//                                               title: '${product.productName}',
//                                             );
//                                           });
//                                         },
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           if (searchProductShow.value)
//                             Builder(builder: (context) {
//                               productList.clear();
//                               for (var product in categoryController.selectedPlant?.products ?? []) {
//                                 productList.add(product);
//                               }
//                               return Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: ValueListenableBuilder(
//                                     valueListenable: purchaseController.searchProductValue,
//                                     builder: (context, String search, child) {
//                                       var filteredProducts = productList.where((product) => search.isEmpty || (product.productName?.toLowerCase().contains(search.toLowerCase()) ?? false)).toList();
//                                       if (filteredProducts.isEmpty) {
//                                         return Center(
//                                           child: Text(
//                                             "No products found",
//                                             style: AppFonts.black14.copyWith(fontWeight: FontWeight.bold),
//                                           ),
//                                         );
//                                       }
//                                       return DynamicHeightGridView(
//                                         crossAxisCount: 3,
//                                         crossAxisSpacing: 5,
//                                         mainAxisSpacing: 5,
//                                         itemCount: productList.where((product) => search.isEmpty || (product.productName?.toLowerCase().contains(search.toLowerCase()) ?? false)).length,
//                                         builder: (context, index) {
//                                           var product = filteredProducts[index];
//                                           return Obx(() {
//                                             return AppWidgets.gridView(
//                                               onTap: () {
//                                                 selectIndex.value = index;
//                                                 plantName.value = product.productName ?? "";
//                                               },
//                                               color: selectIndex.value == index ? AppColors.green : AppColors.lightblue,
//                                               title: '${product.productName}',
//                                             );
//                                           });
//                                         },
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               );
//                             }),
//                           Obx(
//                             () {
//                               return AppWidgets.incDec(
//                                 onDec: () {
//                                   categoryProductController.decrement();
//                                 },
//                                 onInc: () {
//                                   categoryProductController.increment();
//                                 },
//                                 value: "${categoryProductController.counter.value}",
//                               );
//                             },
//                           ),
//                           AppWidgets.unitDis(
//                             ctr: categoryProductController.unitPriceController,
//                             onSubmitted1: (value) {
//                               categoryProductController.unitPriceController.text = value;
//                               categoryProductController.calculatePrices();
//                             },
//                           ),
//                           Obx(() => Text('Total Price: ${categoryProductController.totalPrice.value.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20))),
//                           AppWidgets.addRemoveButton(
//                             onAdd: () {
//                               if (materialProduct.any((element) => element.items == productList[selectIndex.value].productName)) {
//                                 AppWidgets.toast(msg: "This item is already added");
//                               } else {
//                                 materialProduct.add(
//                                   PurchaseProductModel(
//                                     qty: categoryProductController.counter.value.toString(),
//                                     items: plantName.value,
//                                     itemID: productList[selectIndex.value].id ?? "0",
//                                     itemPrice: categoryProductController.unitPriceController.text,
//                                     itemTotalPrice: categoryProductController.totalPrice.value.toString(),
//                                     emsCode: productList[selectIndex.value].emsCode ?? "",
//                                     itemName: productList[selectIndex.value].productName ?? "",
//                                     productId: "${productList[selectIndex.value].subId}",
//                                     partNO: productList[selectIndex.value].partNo ?? "",
//                                     rootName: productList[selectIndex.value].rootName ?? "",
//                                   ),
//                                 );
//                                 categoryProductController.calculateTotals(plantProduct, materialProduct, accessProduct);
//                                 rootCatShow.value = true;
//                                 subCatShow.value = false;
//                                 productShow.value = false;
//                                 rootCatName = '';
//                                 subCatName = '';
//                                 selectIndex.value = -1;
//                                 subCategoryList.clear();
//                                 listChange.value = Random().nextInt(9999999);
//                                 categoryProductController.counter.value = 0;
//                                 categoryProductController.unitPriceController.text = '0.0';
//                                 categoryProductController.isVisible2.value = true;
//                                 listChange.value = Random().nextInt(9999999);
//                                 FocusScope.of(context).unfocus();
//                                 Get.back();
//                               }
//                             },
//                             onRemove: () {
//                               rootCatShow.value = true;
//                               subCatShow.value = false;
//                               productShow.value = false;
//                               rootCatName = '';
//                               subCatName = '';
//                               selectIndex.value = -1;
//                               subCategoryList.clear();
//                               listChange.value = Random().nextInt(9999999);
//                               categoryProductController.totalPrice.value = 0.0;
//                               categoryProductController.counter.value = 0;
//                               categoryProductController.unitPrice.value = 0.0;
//                               categoryProductController.unitPriceController.text = '0.0';
//                               Get.back();
//                             },
//                             removeText: "Cancel",
//                           ),
//                         ],
//                       );
//                     }),
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Future<dynamic> addPlanDialogue(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return ValueListenableBuilder(
//           valueListenable: listChange,
//           builder: (context, value, child) {
//             return BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//               child: Dialog(
//                 insetPadding: const EdgeInsets.all(20),
//                 backgroundColor: AppColors.white,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
//                 child: Obx(() {
//                   return Column(
//                     children: [
//                       Container(
//                           decoration: const BoxDecoration(color: AppColors.lightblue),
//                           child: AppBar(
//                             backgroundColor: AppColors.lightblue,
//                             leading: IconButton(
//                               onPressed: () => Get.back(),
//                               icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
//                             ),
//                             title: AppWidgets.customText(text: 'Select Tools', style: AppFonts.white18.copyWith(fontWeight: FontWeight.bold, fontSize: 18.sp)),
//                           )),
//                       Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                         decoration: BoxDecoration(
//                           color: AppColors.darkBlue.withValues(alpha: 0.6),
//                         ),
//                         child: AppWidgets.searchTextFeild(
//                           onChanged: (value) => purchaseController.searchProductValue.value = value,
//                           onTap: () {
//                             searchProductShow.value = true;
//                             rootCatShow.value = false;
//                             subCatShow.value = false;
//                             productShow.value = false;
//                             rootCatName = '';
//                             subCatName = '';
//                             selectIndex.value = -1;
//                             subCategoryList.clear();
//                             listChange.value = Random().nextInt(9999999);
//                           },
//                           controller: purchaseController.searchFieldController,
//                           suffixIcon: Visibility(
//                             visible: searchProductShow.value,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: CircleAvatar(
//                                 backgroundColor: AppColors.red,
//                                 child: IconButton(
//                                   onPressed: () {
//                                     purchaseController.searchProductValue.value = '';
//                                     purchaseController.searchFieldController.clear();
//                                     rootCatShow.value = true;
//                                     subCatShow.value = false;
//                                     productShow.value = false;
//                                     searchProductShow.value = false;
//                                     rootCatName = '';
//                                     subCatName = '';
//                                     selectIndex.value = -1;
//                                     subCategoryList.clear();
//                                     FocusScope.of(context).unfocus();
//                                     listChange.value = Random().nextInt(9999999);
//                                   },
//                                   icon: const Icon(Icons.close, color: AppColors.white),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       if (rootCatName.isNotEmpty)
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
//                           child: SingleChildScrollView(
//                             padding: EdgeInsets.zero,
//                             scrollDirection: Axis.horizontal,
//                             child: SizedBox(
//                               width: Get.width,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   InkWell(
//                                     onTap: () {
//                                       rootCatShow.value = true;
//                                       subCatShow.value = false;
//                                       productShow.value = false;
//                                       rootCatName = '';
//                                       subCatName = '';
//                                       subCategoryList.clear();
//                                       purchaseController.searchFieldController.clear();
//                                       purchaseController.searchProductValue.value = '';
//                                       listChange.value = Random().nextInt(9999999);
//                                     },
//                                     child: AppWidgets.customText(text: rootCatName, style: AppFonts.lightBlueColor16.copyWith(fontSize: 14)),
//                                   ),
//                                   const Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: 3.0),
//                                     child: Icon(Icons.arrow_forward_ios, size: 18, color: AppColors.lightblue),
//                                   ),
//                                   if (subCatName.isNotEmpty)
//                                     InkWell(
//                                       onTap: () {
//                                         rootCatShow.value = false;
//                                         subCatShow.value = true;
//                                         productShow.value = false;
//                                         subCatName = '';
//                                         productList.clear();
//                                         purchaseController.searchFieldController.clear();
//                                         purchaseController.searchProductValue.value = '';
//                                         listChange.value = Random().nextInt(9999999);
//                                       },
//                                       child: AppWidgets.customText(text: subCatName, style: AppFonts.lightBlueColor16.copyWith(fontSize: 14)),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       if (rootCatShow.isFalse) SizedBox(height: Get.height * 0.01),
//                       if (rootCatShow.value)
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: ValueListenableBuilder(
//                               valueListenable: purchaseController.searchProductValue,
//                               builder: (context, String search, child) {
//                                 return DynamicHeightGridView(
//                                   crossAxisCount: 3,
//                                   crossAxisSpacing: 5,
//                                   mainAxisSpacing: 7,
//                                   itemCount: categoryController.selectedPlant?.pRootCategories?.where((category) => search.isEmpty || (category.rootName?.toLowerCase().contains(search.toLowerCase()) ?? false)).length ?? 0,
//                                   builder: (context, index) {
//                                     var filteredCategories = categoryController.selectedPlant?.pRootCategories?.where((category) => search.isEmpty || (category.rootName?.toLowerCase().contains(search.toLowerCase()) ?? false)).toList() ?? [];
//                                     var category = filteredCategories[index];
//                                     return AppWidgets.gridView(
//                                       onTap: () {
//                                         rootCatName = category.rootName ?? '';
//                                         rootCatShow.value = false;
//                                         subCatShow.value = false;
//                                         productShow.value = true;
//                                         listChange.value = Random().nextInt(9999999);
//                                         purchaseController.searchFieldController.clear();
//                                         purchaseController.searchProductValue.value = '';
//                                         FocusScope.of(context).unfocus();
//                                         var selectedRootId = category.rootId;
//                                         productList2.clear();
//                                         for (var product in categoryController.selectedPlant?.pProducts ?? []) {
//                                           if (product.rootId == selectedRootId) {
//                                             productList2.add(product);
//                                           }
//                                         }
//                                       },
//                                       color: AppColors.lightblue,
//                                       title: '${category.rootName}',
//                                     );
//                                   },
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       if (productShow.value)
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: ValueListenableBuilder(
//                               valueListenable: purchaseController.searchProductValue,
//                               builder: (context, String search, child) {
//                                 return DynamicHeightGridView(
//                                   crossAxisCount: 3,
//                                   crossAxisSpacing: 5,
//                                   mainAxisSpacing: 7,
//                                   itemCount: productList2.where((product) => search.isEmpty || (product.productName?.toLowerCase().contains(search.toLowerCase()) ?? false)).length,
//                                   builder: (context, index) {
//                                     var filteredProducts = productList2.where((product) => search.isEmpty || (product.productName?.toLowerCase().contains(search.toLowerCase()) ?? false)).toList();
//                                     var product = filteredProducts[index];
//                                     return Obx(() {
//                                       return AppWidgets.gridView(
//                                         onTap: () {
//                                           subCatName = '${product.rootName}';
//                                           selectIndex.value = index;
//                                           plantName.value = product.productName!;
//                                         },
//                                         color: selectIndex.value == index ? AppColors.green : AppColors.lightblue,
//                                         title: "${product.productName}",
//                                       );
//                                     });
//                                   },
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       if (searchProductShow.value)
//                         Builder(
//                           builder: (context) {
//                             productList2.clear();
//                             for (var product in categoryController.selectedPlant!.pProducts!) {
//                               productList2.add(product);
//                             }
//                             return Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: ValueListenableBuilder(
//                                   valueListenable: purchaseController.searchProductValue,
//                                   builder: (context, String search, child) {
//                                     var filteredProducts = productList2.where((product) => search.isEmpty || (product.productName?.toLowerCase().contains(search.toLowerCase()) ?? false)).toList();
//                                     if (filteredProducts.isEmpty) {
//                                       return Center(
//                                         child: Text(
//                                           "No products found",
//                                           style: AppFonts.black14.copyWith(fontWeight: FontWeight.bold),
//                                         ),
//                                       );
//                                     }
//                                     return DynamicHeightGridView(
//                                       crossAxisCount: 3,
//                                       crossAxisSpacing: 5,
//                                       mainAxisSpacing: 7,
//                                       itemCount: filteredProducts.length,
//                                       builder: (context, index) {
//                                         var product = filteredProducts[index];
//                                         return Obx(() {
//                                           return AppWidgets.gridView(
//                                             onTap: () {
//                                               subCatName = '${product.rootName}';
//                                               selectIndex.value = index;
//                                               plantName.value = product.productName!;
//                                             },
//                                             color: selectIndex.value == index ? AppColors.green : AppColors.lightblue,
//                                             title: "${product.productName}",
//                                           );
//                                         });
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       Obx(() {
//                         return AppWidgets.incDec(
//                           onDec: () => categoryProductController.decrement(),
//                           onInc: () => categoryProductController.increment(),
//                           value: "${categoryProductController.counter.value}",
//                         );
//                       }),
//                       AppWidgets.unitDis(
//                         ctr: categoryProductController.unitPriceController,
//                         onSubmitted1: (value) {
//                           categoryProductController.unitPriceController.text = value;
//                           categoryProductController.calculatePrices();
//                         },
//                       ),
//                       Obx(
//                         () => AppWidgets.snText(
//                           text: 'Total Price: ${categoryProductController.totalPrice.value.toStringAsFixed(2)}',
//                           style: AppFonts.black16.copyWith(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       AppWidgets.addRemoveButton(
//                         onAdd: () {
//                           if (plantProduct.any((element) => element.productId == productList2[selectIndex.value].id)) {
//                             AppWidgets.toast(msg: "This item is already added");
//                           } else {
//                             plantProduct.add(PurchaseProductModel(
//                               qty: categoryProductController.counter.value.toString() == '' ? '0' : categoryProductController.counter.value.toString(),
//                               items: plantName.value,
//                               itemID: productList2[selectIndex.value].id!,
//                               itemPrice: categoryProductController.unitPriceController.text == '' ? '0.0' : categoryProductController.unitPriceController.text,
//                               itemTotalPrice: categoryProductController.totalPrice.value.toString(),
//                               productId: productList2[selectIndex.value].id!,
//                               rootName: productList2[selectIndex.value].rootName!,
//                             ));
//
//                             categoryProductController.calculateTotals(plantProduct, materialProduct, accessProduct);
//                             rootCatShow.value = true;
//                             subCatShow.value = false;
//                             productShow.value = false;
//                             rootCatName = '';
//                             subCatName = '';
//                             selectIndex.value = -1;
//                             subCategoryList.clear();
//                             listChange.value = Random().nextInt(9999999);
//                             categoryProductController.counter.value = 0;
//                             categoryProductController.unitPriceController.text = '0.0';
//                             categoryProductController.isVisible.value = true;
//                             listChange.value = Random().nextInt(9999999);
//                             FocusScope.of(context).unfocus();
//                             Get.back();
//                           }
//                         },
//                         onRemove: () {
//                           rootCatShow.value = true;
//                           subCatShow.value = false;
//                           productShow.value = false;
//                           rootCatName = '';
//                           subCatName = '';
//                           selectIndex.value = -1;
//                           subCategoryList.clear();
//                           listChange.value = Random().nextInt(9999999);
//                           categoryProductController.totalPrice.value = 0.0;
//                           categoryProductController.counter.value = 0;
//                           categoryProductController.unitPrice.value = 0.0;
//                           categoryProductController.unitPriceController.text = '0.0';
//                           FocusScope.of(context).unfocus();
//                           Get.back();
//                         },
//                         removeText: "Cancel",
//                       ),
//                     ],
//                   );
//                 }),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   void showSiteModal(BuildContext context) {
//     TextEditingController searchController = TextEditingController();
//     List<SiteDataModel> filteredSites = siteController.sitesList;
//
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return Container(
//               height: Get.height * 0.8,
//               color: Colors.white,
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       controller: searchController,
//                       decoration: const InputDecoration(
//                         labelText: 'Search site',
//                         prefixIcon: Icon(Icons.search),
//                         border: OutlineInputBorder(),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           filteredSites = siteController.sitesList.where((site) => site.jobNo!.toLowerCase().contains(value.toLowerCase()) || site.projectName!.toLowerCase().contains(value.toLowerCase())).toList();
//                         });
//                       },
//                     ),
//                   ),
//                   // Display filtered list
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: filteredSites.length,
//                       itemBuilder: (context, index) {
//                         var site = filteredSites.reversed.toList()[index];
//                         return ListTile(
//                           title: Text('${site.jobNo} - ${site.projectName}', style: AppFonts.black14),
//                           onTap: () {
//                             setState(() {
//                               siteAddress = site.jobId!;
//                               category.value = site.jobId!;
//                               selectedProject.value = '${site.jobNo} - ${site.projectName}';
//                               purchaseController.generatePONumber(site.jobId!);
//                               purchaseController.generatePONumber(category.value);
//                             });
//                             Navigator.of(context).pop();
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
