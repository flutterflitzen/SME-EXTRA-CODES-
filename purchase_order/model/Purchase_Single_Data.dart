// // To parse this JSON data, do
// //
// //     final purchaseSingleData = purchaseSingleDataFromJson(jsonString);
//
// import 'dart:convert';
//
// PurchaseSingleData purchaseSingleDataFromJson(String str) => PurchaseSingleData.fromJson(json.decode(str));
//
// String purchaseSingleDataToJson(PurchaseSingleData data) => json.encode(data.toJson());
//
// class PurchaseSingleData {
//   PoData? poData;
//   PoDetails? poDetails;
//   int? status;
//   String? message;
//
//   PurchaseSingleData({
//     this.poData,
//     this.poDetails,
//     this.status,
//     this.message,
//   });
//
//   factory PurchaseSingleData.fromJson(Map<String, dynamic> json) => PurchaseSingleData(
//         poData: json["po_data"] == null ? null : PoData.fromJson(json["po_data"]),
//         poDetails: json["po_details"] == null ? null : PoDetails.fromJson(json["po_details"]),
//         status: json["status"],
//         message: json["message"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "po_data": poData?.toJson(),
//         "po_details": poDetails?.toJson(),
//         "status": status,
//         "message": message,
//       };
// }
//
// class PoData {
//   String? poId;
//   String? poStatus;
//   String? poNumber;
//   String? jobId;
//   String? projectName;
//   String? referanceNumber;
//   String? fullDeliveryAddress;
//   DateTime? poDate;
//   DateTime? expDeliveryDate;
//   String? additionalNotes;
//   String? subTotal;
//   String? plantVatAmount;
//   String? materialVatAmount;
//   String? accessEquipmentVatAmount;
//   String? totalVatAmount;
//   String? totalAmount;
//   String? emailMsg;
//   String? emailOn;
//   String? addedBy;
//   String? lastEditedBy;
//   DateTime? createdAt;
//   DateTime? lastUpdated;
//   String? supplierId;
//   String? supplierName;
//   List<SupplierContact>? supplierContacts;
//   dynamic supplierContantEmail;
//   List<ATTACHMENTS>? aTTACHMENTS;
//
//   PoData({
//     this.poId,
//     this.poStatus,
//     this.poNumber,
//     this.jobId,
//     this.projectName,
//     this.referanceNumber,
//     this.fullDeliveryAddress,
//     this.poDate,
//     this.expDeliveryDate,
//     this.additionalNotes,
//     this.subTotal,
//     this.plantVatAmount,
//     this.materialVatAmount,
//     this.accessEquipmentVatAmount,
//     this.totalVatAmount,
//     this.totalAmount,
//     this.emailMsg,
//     this.emailOn,
//     this.addedBy,
//     this.lastEditedBy,
//     this.createdAt,
//     this.lastUpdated,
//     this.supplierId,
//     this.supplierName,
//     this.supplierContacts,
//     this.supplierContantEmail,
//     this.aTTACHMENTS,
//   });
//
//   factory PoData.fromJson(Map<String, dynamic> json) => PoData(
//         poId: json["PO_ID"],
//         poStatus: json["PO_STATUS"],
//         poNumber: json["PO_NUMBER"],
//         jobId: json["JOB_ID"],
//         projectName: json["PROJECT_NAME"],
//         referanceNumber: json["REFERANCE_NUMBER"],
//         fullDeliveryAddress: json["FULL_DELIVERY_ADDRESS"],
//         poDate: json["PO_DATE"] == null ? null : DateTime.parse(json["PO_DATE"]),
//         expDeliveryDate: json["EXP_DELIVERY_DATE"] == null ? null : DateTime.parse(json["EXP_DELIVERY_DATE"]),
//         additionalNotes: json["ADDITIONAL_NOTES"],
//         subTotal: json["SUB_TOTAL"],
//         plantVatAmount: json["PLANT_VAT_AMOUNT"],
//         materialVatAmount: json["MATERIAL_VAT_AMOUNT"],
//         accessEquipmentVatAmount: json["ACCESS_EQUIPMENT_VAT_AMOUNT"],
//         totalVatAmount: json["TOTAL_VAT_AMOUNT"],
//         totalAmount: json["TOTAL_AMOUNT"],
//         emailMsg: json["EMAIL_MSG"],
//         emailOn: json["EMAIL_ON"],
//         addedBy: json["ADDED_BY"],
//         lastEditedBy: json["LAST_EDITED_BY"],
//         createdAt: json["CREATED_AT"] == null ? null : DateTime.parse(json["CREATED_AT"]),
//         lastUpdated: json["LAST_UPDATED"] == null ? null : DateTime.parse(json["LAST_UPDATED"]),
//         supplierId: json["SUPPLIER_ID"],
//         supplierName: json["SUPPLIER_NAME"],
//         supplierContacts: json["SUPPLIER_CONTACTS"] == null ? [] : List<SupplierContact>.from(json["SUPPLIER_CONTACTS"].map((x) => SupplierContact.fromJson(x))),
//         supplierContantEmail: json["SUPPLIER_CONTANT_EMAIL"],
//         aTTACHMENTS: json["ATTACHMENTS"] == null ? [] : List<ATTACHMENTS>.from(json["ATTACHMENTS"].map((x) => ATTACHMENTS.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "PO_ID": poId,
//         "PO_STATUS": poStatus,
//         "PO_NUMBER": poNumber,
//         "JOB_ID": jobId,
//         "PROJECT_NAME": projectName,
//         "REFERANCE_NUMBER": referanceNumber,
//         "FULL_DELIVERY_ADDRESS": fullDeliveryAddress,
//         "PO_DATE": "${poDate!.year.toString().padLeft(4, '0')}-${poDate!.month.toString().padLeft(2, '0')}-${poDate!.day.toString().padLeft(2, '0')}",
//         "EXP_DELIVERY_DATE": "${expDeliveryDate!.year.toString().padLeft(4, '0')}-${expDeliveryDate!.month.toString().padLeft(2, '0')}-${expDeliveryDate!.day.toString().padLeft(2, '0')}",
//         "ADDITIONAL_NOTES": additionalNotes,
//         "SUB_TOTAL": subTotal,
//         "PLANT_VAT_AMOUNT": plantVatAmount,
//         "MATERIAL_VAT_AMOUNT": materialVatAmount,
//         "ACCESS_EQUIPMENT_VAT_AMOUNT": accessEquipmentVatAmount,
//         "TOTAL_VAT_AMOUNT": totalVatAmount,
//         "TOTAL_AMOUNT": totalAmount,
//         "EMAIL_MSG": emailMsg,
//         "EMAIL_ON": emailOn,
//         "ADDED_BY": addedBy,
//         "LAST_EDITED_BY": lastEditedBy,
//         "CREATED_AT": createdAt?.toIso8601String(),
//         "LAST_UPDATED": lastUpdated?.toIso8601String(),
//         "SUPPLIER_ID": supplierId,
//         "SUPPLIER_NAME": supplierName,
//         "SUPPLIER_CONTACTS": supplierContacts == null ? [] : List<dynamic>.from(supplierContacts!.map((x) => x.toJson())),
//         "SUPPLIER_CONTANT_EMAIL": supplierContantEmail,
//         "ATTACHMENTS": aTTACHMENTS == null ? [] : List<dynamic>.from(aTTACHMENTS!.map((x) => x.toJson())),
//       };
// }
//
// class ATTACHMENTS {
//   String? iMAGE;
//
//   ATTACHMENTS({this.iMAGE});
//
//   ATTACHMENTS.fromJson(Map<String, dynamic> json) {
//     iMAGE = json['IMAGE'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['IMAGE'] = iMAGE;
//     return data;
//   }
// }
//
// class PoDetails {
//   List<PurchaseOrderDatum2>? plantData;
//   List<PurchaseOrderDatum2>? materialData;
//   List<PurchaseOrderDatum2>? accessEquipmentData;
//
//   PoDetails({
//     this.plantData,
//     this.materialData,
//     this.accessEquipmentData,
//   });
//
//   factory PoDetails.fromJson(Map<String, dynamic> json) => PoDetails(
//         plantData: json["plant_data"] == null ? [] : List<PurchaseOrderDatum2>.from(json["plant_data"]!.map((x) => PurchaseOrderDatum2.fromJson(x))),
//         materialData: json["material_data"] == null ? [] : List<PurchaseOrderDatum2>.from(json["material_data"]!.map((x) => PurchaseOrderDatum2.fromJson(x))),
//         accessEquipmentData: json["access_equipment_data"] == null ? [] : List<PurchaseOrderDatum2>.from(json["access_equipment_data"]!.map((x) => PurchaseOrderDatum2.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "plant_data": plantData == null ? [] : List<dynamic>.from(plantData!.map((x) => x.toJson())),
//         "material_data": materialData == null ? [] : List<dynamic>.from(materialData!.map((x) => x.toJson())),
//         "access_equipment_data": accessEquipmentData == null ? [] : List<dynamic>.from(accessEquipmentData!.map((x) => x.toJson())),
//       };
// }
//
// class SupplierContact {
//   String? id;
//   String? name;
//   String? email;
//
//   SupplierContact({
//     this.id,
//     this.name,
//     this.email,
//   });
//
//   factory SupplierContact.fromJson(Map<String, dynamic> json) => SupplierContact(
//         id: json["ID"],
//         name: json["NAME"],
//         email: json["EMAIL"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "ID": id,
//         "NAME": name,
//         "EMAIL": email,
//       };
// }
//
// class PurchaseOrderDatum2 {
//   String? poId;
//   String? item;
//   String? emsCode;
//   String? type;
//   String? qty;
//   String? unitprice;
//   String? amount;
//   String? discount;
//   String? taxValue;
//   String? partNo;
//   String? itemName;
//
//   PurchaseOrderDatum2({
//     this.poId,
//     this.item,
//     this.emsCode,
//     this.type,
//     this.qty,
//     this.unitprice,
//     this.amount,
//     this.discount,
//     this.taxValue,
//     this.partNo,
//     this.itemName,
//   });
//
//   factory PurchaseOrderDatum2.fromJson(Map<String, dynamic> json) => PurchaseOrderDatum2(
//         poId: json["PO_ID"],
//         item: json["ITEM"],
//         emsCode: json["EMS_CODE"],
//         type: json["TYPE"],
//         qty: json["QTY"],
//         unitprice: json["UNITPRICE"],
//         amount: json["AMOUNT"],
//         discount: json["DISCOUNT"],
//         taxValue: json["TAX_VALUE"],
//         partNo: json["PART_NO"],
//         itemName: json["ITEM_NAME"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "PO_ID": poId,
//         "ITEM": item,
//         "EMS_CODE": emsCode,
//         "TYPE": type,
//         "QTY": qty,
//         "UNITPRICE": unitprice,
//         "AMOUNT": amount,
//         "DISCOUNT": discount,
//         "TAX_VALUE": taxValue,
//         "PART_NO": partNo,
//         "ITEM_NAME": itemName,
//       };
// }
