// // To parse this JSON data, do
// //
// //     final purchaseMaterialGetData = purchaseMaterialGetDataFromJson(jsonString);
//
// import 'dart:convert';
//
// PurchaseMaterialGetData purchaseMaterialGetDataFromJson(String str) => PurchaseMaterialGetData.fromJson(json.decode(str));
//
// String purchaseMaterialGetDataToJson(PurchaseMaterialGetData data) => json.encode(data.toJson());
//
// class PurchaseMaterialGetData {
//   List<Datum>? data;
//   List<DataContact>? dataContact;
//   String? totalMaterial;
//   int? status;
//   String? message;
//
//   PurchaseMaterialGetData({
//     this.data,
//     this.dataContact,
//     this.totalMaterial,
//     this.status,
//     this.message,
//   });
//
//   factory PurchaseMaterialGetData.fromJson(Map<String, dynamic> json) => PurchaseMaterialGetData(
//     data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//     dataContact: json["data_contact"] == null ? [] : List<DataContact>.from(json["data_contact"]!.map((x) => DataContact.fromJson(x))),
//     totalMaterial: json["total_material"],
//     status: json["status"],
//     message: json["message"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//     "data_contact": dataContact == null ? [] : List<dynamic>.from(dataContact!.map((x) => x.toJson())),
//     "total_material": totalMaterial,
//     "status": status,
//     "message": message,
//   };
// }
//
// class Datum {
//   String? id;
//   String? emsCode;
//   String? partNumber;
//   String? productName;
//   String? unitPrice;
//
//   Datum({
//     this.id,
//     this.emsCode,
//     this.partNumber,
//     this.productName,
//     this.unitPrice,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     emsCode: json["ems_code"],
//     partNumber: json["part_number"],
//     productName: json["product_name"],
//     unitPrice: json["unit_price"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "ems_code": emsCode,
//     "part_number": partNumber,
//     "product_name": productName,
//     "unit_price": unitPrice,
//   };
// }
//
// class DataContact {
//   String? name;
//   String? email;
//   String? id;
//
//   DataContact({
//     this.name,
//     this.email,
//     this.id,
//   });
//
//   factory DataContact.fromJson(Map<String, dynamic> json) => DataContact(
//     name: json["name"],
//     email: json["email"],
//     id: json["id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "email": email,
//     "id": id,
//   };
// }
