// import 'dart:convert';
//
// SiteDiaryDataModel siteDiaryDataModelFromJson(String str) => SiteDiaryDataModel.fromJson(json.decode(str));
//
// String siteDiaryDataModelToJson(SiteDiaryDataModel data) => json.encode(data.toJson());
//
// class SiteDiaryDataModel {
//   String id;
//   String jobId;
//   String jobNo;
//   String siteAddress;
//   List<String> attachments;
//   String date;
//   String name;
//   String statusName;
//   List<SiteDiaryDetail> siteDiaryDetails;
//
//   SiteDiaryDataModel({
//     required this.id,
//     required this.jobId,
//     required this.jobNo,
//     required this.siteAddress,
//     required this.attachments,
//     required this.date,
//     required this.name,
//     required this.siteDiaryDetails,
//     required this.statusName,
//   });
//
//   factory SiteDiaryDataModel.fromJson(Map<String, dynamic> json) => SiteDiaryDataModel(
//         id: json["id"] ?? 'N/A',
//         jobId: json["job_id"] ?? 'N/A',
//         jobNo: json["job_no"] ?? 'N/A',
//         siteAddress: json["site_address"] ?? 'N/A',
//         attachments: json["attachments"] is List
//             ? List<String>.from(json["attachments"].map((x) => x.toString()))
//             : (json["attachments"] != null && json["attachments"].toString().isNotEmpty)
//                 ? json["attachments"].toString().split(',').map((e) => e.trim()).toList()
//                 : [],
//         date: json["date"] ?? 'N/A',
//         name: json["name"] ?? 'N/A',
//         statusName: json["status_name"] ?? 'N/A',
//         siteDiaryDetails: List<SiteDiaryDetail>.from(json["site_diary_details"].map((x) => SiteDiaryDetail.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "job_id": jobId,
//         "job_no": jobNo,
//         "site_address": siteAddress,
//         "attachments": List<String>.from(attachments.map((x) => x.toString())),
//         "date": date,
//         "name": name,
//         "status_name": statusName,
//         "site_diary_details": List<dynamic>.from(siteDiaryDetails.map((x) => x.toJson())),
//       };
// }
//
// class SiteDiaryDetail {
//   String siteDetailId;
//   String trade;
//   String menNo;
//   String hoursWorked;
//   String description;
//
//   SiteDiaryDetail({
//     required this.siteDetailId,
//     required this.trade,
//     required this.menNo,
//     required this.hoursWorked,
//     required this.description,
//   });
//
//   factory SiteDiaryDetail.fromJson(Map<String, dynamic> json) => SiteDiaryDetail(
//         siteDetailId: json["site_detail_id"],
//         trade: json["trade"],
//         menNo: json["men_no"],
//         hoursWorked: json["hours_worked"],
//         description: json["description"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "site_detail_id": siteDetailId,
//         "trade": trade,
//         "men_no": menNo,
//         "hours_worked": hoursWorked,
//         "description": description,
//       };
// }
