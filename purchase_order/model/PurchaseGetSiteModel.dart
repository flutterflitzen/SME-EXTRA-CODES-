// import 'dart:convert';
//
// List<PurchaseGetSiteData> purchaseGetSiteDataFromJson(String str) => List<PurchaseGetSiteData>.from(json.decode(str).map((x) => PurchaseGetSiteData.fromJson(x)));
//
// String purchaseGetSiteDataToJson(List<PurchaseGetSiteData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class PurchaseGetSiteData {
//   String? supplierId;
//   String? supplierName;
//   List<ContactEmail>? contactEmails;
//
//   PurchaseGetSiteData({
//     this.supplierId,
//     this.supplierName,
//     this.contactEmails,
//   });
//
//   factory PurchaseGetSiteData.fromJson(Map<String, dynamic> json) => PurchaseGetSiteData(
//     supplierId: json["SUPPLIER_ID"],
//     supplierName: json["SUPPLIER_NAME"],
//     contactEmails: json["CONTACT_EMAILS"] == null ? [] : List<ContactEmail>.from(json["CONTACT_EMAILS"]!.map((x) => ContactEmail.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "SUPPLIER_ID": supplierId,
//     "SUPPLIER_NAME": supplierName,
//     "CONTACT_EMAILS": contactEmails == null ? [] : List<dynamic>.from(contactEmails!.map((x) => x.toJson())),
//   };
// }
//
// class ContactEmail {
//   String? id;
//   String? email;
//   String? name;
//
//   ContactEmail({
//     this.id,
//     this.email,
//     this.name,
//   });
//
//   factory ContactEmail.fromJson(Map<String, dynamic> json) => ContactEmail(
//     id: json["ID"],
//     email: json["EMAIL"],
//     name: json["NAME"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "ID": id,
//     "EMAIL": email,
//     "NAME": name,
//   };
// }
