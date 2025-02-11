// // To parse this JSON data, do
// //
// //     final purchaseGetData = purchaseGetDataFromJson(jsonString);
//
// import 'dart:convert';
//
// PurchaseGetData purchaseGetDataFromJson(String str) => PurchaseGetData.fromJson(json.decode(str));
//
// String purchaseGetDataToJson(PurchaseGetData data) => json.encode(data.toJson());
//
// class PurchaseGetData {
//   List<PurchaseOrderData>? data;
//   String? totalAll;
//   String? totalCompleted;
//   String? totalPending;
//   int? status;
//   String? message;
//
//   PurchaseGetData({
//     this.data,
//     this.totalAll,
//     this.totalCompleted,
//     this.totalPending,
//     this.status,
//     this.message,
//   });
//
//   factory PurchaseGetData.fromJson(Map<String, dynamic> json) => PurchaseGetData(
//         data: json["data"] == null ? [] : List<PurchaseOrderData>.from(json["data"]!.map((x) => PurchaseOrderData.fromJson(x))),
//         totalAll: json["total_all"],
//         totalCompleted: json["total_completed"],
//         totalPending: json["total_pending"],
//         status: json["status"],
//         message: json["message"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "total_all": totalAll,
//         "total_completed": totalCompleted,
//         "total_pending": totalPending,
//         "status": status,
//         "message": message,
//       };
// }
//
// class PurchaseOrderData {
//   String? poId;
//   String? poNumber;
//   String? supplierName;
//   String? supplierId;
//   String? poStatus;
//   String? rejectReason;
//   String? statusName;
//   String? poDate;
//   String? totalAmount;
//   String? jobNo;
//   String? pdfUrl;
//   String? isArchive;
//   String? poStatusName;
//   List<GrnDatum>? grnData;
//   List<dynamic>? grnReturnData;
//   List<PoAttachments>? poAttachments;
//
//   PurchaseOrderData({
//     this.poId,
//     this.poNumber,
//     this.supplierName,
//     this.supplierId,
//     this.poStatus,
//     this.rejectReason,
//     this.statusName,
//     this.poDate,
//     this.totalAmount,
//     this.jobNo,
//     this.pdfUrl,
//     this.isArchive,
//     this.poStatusName,
//     this.grnData,
//     this.grnReturnData,
//     this.poAttachments,
//   });
//
//   factory PurchaseOrderData.fromJson(Map<String, dynamic> json) => PurchaseOrderData(
//         poId: json["po_id"],
//         poNumber: json["po_number"],
//         supplierName: json["supplier_name"],
//         supplierId: json["supplier_id"],
//         poStatus: json["po_status"],
//         rejectReason: json["reject_reason"],
//         statusName: json["po_status_name"],
//         poDate: json["po_date"],
//         totalAmount: json["total_amount"],
//         jobNo: json["job_no"],
//         pdfUrl: json["pdf_url"],
//         isArchive: json["is_archive"],
//         poStatusName: json["po_status_name"],
//         grnData: json["grn_data"] == null ? [] : List<GrnDatum>.from(json["grn_data"]!.map((x) => GrnDatum.fromJson(x))),
//         grnReturnData: json["grn_return_data"] == null ? [] : List<dynamic>.from(json["grn_return_data"]!.map((x) => x)),
//         poAttachments: json["po_attachments"] == null ? [] : List<PoAttachments>.from(json["po_attachments"].map((x) => PoAttachments.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "po_id": poId,
//         "po_number": poNumber,
//         "supplier_name": supplierName,
//         "supplier_id": supplierId,
//         "po_status": poStatus,
//         "reject_reason": rejectReason,
//         "po_date": poDate,
//         "total_amount": totalAmount,
//         "job_no": jobNo,
//         "pdf_url": pdfUrl,
//         "is_archive": isArchive,
//         "po_status_name": poStatusName,
//         "grn_data": grnData == null ? [] : List<dynamic>.from(grnData!.map((x) => x.toJson())),
//         "grn_return_data": grnReturnData == null ? [] : List<dynamic>.from(grnReturnData!.map((x) => x)),
//         "po_attachments": poAttachments == null ? [] : List<dynamic>.from(poAttachments!.map((x) => x.toJson())),
//       };
// }
//
// class PoAttachments {
//   String? iMAGE;
//
//   PoAttachments({this.iMAGE});
//
//   PoAttachments.fromJson(Map<String, dynamic> json) {
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
// class GrnDatum {
//   String? number;
//   String? createdAt;
//   String? pdf;
//
//   GrnDatum({
//     this.number,
//     this.createdAt,
//     this.pdf,
//   });
//
//   factory GrnDatum.fromJson(Map<String, dynamic> json) => GrnDatum(
//         number: json["number"],
//         createdAt: json["created_at"],
//         pdf: json["pdf"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "number": number,
//         "created_at": createdAt,
//         "pdf": pdf,
//       };
// }
