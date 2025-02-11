//onTap: () async {
//   String uid = await HiveDB.getData(AppStrings.UID);
//
//   // Helper function to build common data map
//   Map<String, dynamic> buildCommonData() {
//     return {
//       "USER_ID": uid,
//       "PO_NUMBER": purchaseController.poNumber.value,
//       "JOB_ID": category.value,
//       "SUPPLIER_ID": SupllierID,
//       "CUSTOM_SUPPLIER_NAME": customeSupplier,
//       "ADDITIONAL_NOTES": noteController.text,
//     };
//   }
//
//   // Helper function to add product data
//   void addProductData(Map<String, dynamic> data) {
//     for (var i = 0; i < plantProduct.length; i++) {
//       data['PLANT_ITEM[$i]'] = plantProduct[i].productId;
//       data['PLANT_QTY[$i]'] = plantProduct[i].qty;
//       data['PLANT_PRICE[$i]'] = plantProduct[i].itemPrice;
//       data['PLANT_AMOUNT[$i]'] = plantProduct[i].itemTotalPrice;
//     }
//
//     for (var i = 0; i < materialProduct.length; i++) {
//       data['ITEM[$i]'] = materialProduct[i].itemID;
//       data['QTY[$i]'] = materialProduct[i].qty;
//       data['PART_NO[$i]'] = materialProduct[i].partNO ?? "";
//       data['UNITPRICE[$i]'] = materialProduct[i].itemPrice;
//       data['AMOUNT[$i]'] = materialProduct[i].itemTotalPrice;
//       data['EMS_CODE[$i]'] = materialProduct[i].emsCode;
//     }
//
//     for (var i = 0; i < accessProduct.length; i++) {
//       data['AE_ITEM[$i]'] = accessProduct[i].itemID;
//       data['AE_QTY[$i]'] = accessProduct[i].qty;
//       data['AE_PRICE[$i]'] = accessProduct[i].itemPrice;
//       data['AE_AMOUNT[$i]'] = accessProduct[i].itemTotalPrice;
//     }
//   }
//
//   // Handle Request Purchase Order
//   if (!widget.isEdit) {
//     if (purchaseController.poNumber.value.isEmpty) {
//       AppWidgets.toast(msg: "Please Select Project");
//       return;
//     }
//     if (estimatedAmount.text.isEmpty) {
//       AppWidgets.toast(msg: "Please Enter Estimated Amount");
//       return;
//     }
//
//     Map<String, dynamic> data = buildCommonData();
//     data.addAll({
//       if (widget.title == "Edit Request Purchase Order") "PO_ID": widget.poId,
//       "PO_DATE": widget.title == "Edit Request Purchase Order" ? dateOrder : apidate2,
//       "TOTAL_AMOUNT": estimatedAmount.text,
//     });
//
//     addProductData(data);
//
//     await purchaseController.addPurchaseOder(data: data);
//     Get.back();
//     purchaseController.getPurchaseData();
//     return;
//   }
//
//   // Handle Edit Purchase Order
//   Map<String, dynamic> data = buildCommonData();
//   data.addAll({
//     "DELIVERY_TYPE": deliveryType.value,
//     "PO_ID": widget.poId,
//     "REFERANCE_NUMBER": refrerenceController.text,
//     "FULL_DELIVERY_ADDRESS": addressController1.text,
//     "PLANT_VAT_AMOUNT": deliveryController.plantVAT.value.toString(),
//     "MATERIAL_VAT_AMOUNT": deliveryController.materialVAT.value.toString(),
//     "ACCESS_EQUIPMENT_VAT_AMOUNT": deliveryController.accessVAT.value.toString(),
//     "PO_DATE": apidate,
//     "EXP_DELIVERY_DATE": apidate2,
//     "SUB_TOTAL": deliveryController.subtotal.value.toString(),
//     "TOTAL_VAT_AMOUNT": deliveryController.vat.value.toString(),
//     "TOTAL_AMOUNT": deliveryController.grandTotal.value.toString(),
//   });
//
//   addProductData(data);
//
//   // Add supplier contacts only for edit purchase order
//   if (widget.title == "Edit Purchase Order") {
//     for (var i = 0; i < selectedContact.length; i++) {
//       data['SUPPLIER_CONTACT[$i]'] = selectedContact[i].id;
//     }
//   } else {
//     for (var i = 0; i < purchaseController.selectedContacts.length; i++) {
//       data['SUPPLIER_CONTACT[$i]'] = purchaseController.selectedContacts[i].id;
//     }
//   }
//
//   await purchaseController.addPurchaseOder(data: data);
//   if (widget.title == "Edit Purchase Order") {
//     Get.back();
//     purchaseController.getPurchaseData();
//   }
// },