// import 'package:dio/dio.dart' as networks;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sme/api/apiservice.dart';
// import 'package:sme/api/apiurl.dart';
// import 'package:sme/app/login/login_view.dart';
// import 'package:sme/app/user/purchase_order/imports.dart';
// import 'package:sme/utils/apppdf.dart';
// import 'model/PurchaseGetData.dart';
// import 'model/PurchaseMaterialGet.dart';
//
// class PurchaseController extends GetxController {
//   RxList<PurchaseGetData> purchaseList = <PurchaseGetData>[].obs;
//   RxList<PurchaseGetSiteData> poSiteList = <PurchaseGetSiteData>[].obs;
//   RxList<PurchaseMaterialGetData> contactList = <PurchaseMaterialGetData>[].obs;
//   RxList<PurchaseSingleData> singleDataList = <PurchaseSingleData>[].obs;
//
//   RxString poNumber = '--'.obs;
//
//   ValueNotifier<int> refreshScreen = ValueNotifier(0);
//   ValueNotifier<int> refreshImagesChange = ValueNotifier(0);
//
//   PurchaseGetData? purchaseGetData;
//
//   var selectedContacts = <ContactEmail>[].obs;
//
//   RxBool isCollection = false.obs;
//   RxBool isLoading = false.obs;
//
//   TextEditingController searchFieldController = TextEditingController();
//   ValueNotifier<String> searchProductValue = ValueNotifier<String>('');
//
//   TextEditingController addManualMaterialFieldController = TextEditingController();
//
//   void openPdfFile(File file, String url) => Get.to(() => PdfViewerPage(file: file, url: url, date: "SME"));
//
//   RxList<XFile> selectedImages = <XFile>[].obs;
//
//   void clearData() => selectedImages.clear();
//
//   Future<void> pickImages(bool isFromGallery) async {
//     EasyLoading.show();
//     try {
//       if (isFromGallery) {
//         final List<XFile> pickedFiles = await ImagePicker().pickMultiImage(imageQuality: 80);
//         for (XFile file in pickedFiles) {
//           selectedImages.add(file);
//           refreshImagesChange.value = Random().nextInt(999999);
//         }
//         refreshImagesChange.value = Random().nextInt(999999);
//         EasyLoading.dismiss();
//       } else {
//         final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 80);
//         if (pickedFile != null) {
//           selectedImages.add(pickedFile);
//           refreshImagesChange.value = Random().nextInt(999999);
//         }
//         refreshImagesChange.value = Random().nextInt(999999);
//         EasyLoading.dismiss();
//       }
//     } catch (e) {
//       EasyLoading.dismiss();
//       AppWidgets.toast(msg: 'Error picking images', backgroundColor: AppColors.red);
//     }
//   }
//
//   Future<void> getPurchaseData() async {
//     isLoading.value = true;
//     String userId = await HiveDB.getData(AppStrings.UID);
//     var response = await ApiServices().apiService({'user_id': userId, 'po_status': '0'}, ApiUrls.getPO);
//     if (response != null && response.statusCode == 200) {
//       if (response.data['status'] == 1) {
//         purchaseList.clear();
//         purchaseGetData = PurchaseGetData.fromJson(response.data);
//         for (var i in response.data['data']) {
//           purchaseList.add(PurchaseGetData.fromJson(i));
//         }
//         isLoading.value = false;
//       } else if (response.data['status'] == 'access_token_error') {
//         Get.offAll(() => LoginView());
//         isLoading.value = false;
//         AppWidgets.toast(msg: 'Your Login Session has Expired');
//       } else {
//         isLoading.value = false;
//
//         AppWidgets.toast(msg: ' ${response.data['message']}#1');
//       }
//     } else {
//       isLoading.value = false;
//       AppWidgets.toast(msg: 'Something went wrong!!');
//     }
//   }
//
//   Future<void> getPOSiteData() async {
//     var response = await ApiServices().apiService({}, ApiUrls.poSiteList);
//     if (response != null && response.statusCode == 200) {
//       poSiteList.clear();
//       for (var i in response.data) {
//         poSiteList.add(PurchaseGetSiteData.fromJson(i));
//       }
//     }
//   }
//
//   List<Map<String, String>> getContactDetailsBySupplierId(String supplierId) {
//     for (var supplier in poSiteList) {
//       if (supplier.supplierId == supplierId) {
//         final contactEmails = supplier.contactEmails ?? [];
//         return contactEmails.map((email) => {"ID": email.id ?? "", "NAME": email.name ?? "", "EMAIL": email.email ?? ""}).toList();
//       }
//     }
//     return [];
//   }
//
//   bool successAdded = false;
//
//   Future<void> addPurchaseOrderWithFiles({required Map<String, dynamic> data, required RxList<XFile> selectedImages}) async {
//     successAdded = false;
//     EasyLoading.show();
//     try {
//       networks.Dio dio = networks.Dio();
//       networks.FormData formData = networks.FormData.fromMap(data);
//       for (var image in selectedImages) {
//         formData.files.add(
//           MapEntry(
//             'ATTACHMENTS[]',
//             await networks.MultipartFile.fromFile(image.path, filename: image.name),
//           ),
//         );
//       }
//       String accessToken = await HiveDB.getData(AppStrings.accessToken);
//       String deviceName = await HiveDB.getData(AppStrings.deviceManufacturer);
//       String deviceName1 = await HiveDB.getData(AppStrings.deviceModel);
//       String deviceName2 = await HiveDB.getData(AppStrings.deviceBrand);
//       String packageAppVersion = await HiveDB.getData(AppStrings.packageVersion);
//
//       Map<String, String> defaultHeaders = {
//         'Content-Type': "multipart/form-data",
//         'api-access-token': accessToken,
//         'device-name': "$deviceName,$deviceName1,$deviceName2",
//       };
//
//       var response = await dio.post(
//         ApiUrls.addPO,
//         data: formData,
//         options: networks.Options(headers: defaultHeaders),
//         queryParameters: {'app_version': packageAppVersion},
//       );
//       if (response.statusCode == 200 && response.data['status'] == "1") {
//         successAdded = true;
//         EasyLoading.dismiss();
//         selectedImages.clear();
//         Get.back();
//         getPurchaseData();
//         AppWidgets.toast(msg: response.data['message'], backgroundColor: AppColors.green);
//       } else {
//         successAdded = false;
//         EasyLoading.dismiss();
//         AppWidgets.toast(msg: response.data['message'] ?? 'Failed to upload');
//       }
//     } catch (e) {
//       successAdded = false;
//       EasyLoading.dismiss();
//       AppWidgets.toast(msg: 'Something went wrong!!');
//     }
//   }
//
//   Future<void> generatePONumber(String poID) async {
//     String id = await HiveDB.getData(AppStrings.UID);
//     var response = await ApiServices().apiService({'user_id': id, 'job_id': poID}, ApiUrls.poGenerate);
//     if (response != null && response.statusCode == 200) {
//       poNumber.value = response.data;
//     }
//   }
//
//   Future<void> getContactAndMaterial(String supId) async {
//     EasyLoading.show();
//     var response = await ApiServices().apiService({'supplier_id': supId}, ApiUrls.poMaterial);
//     if (response != null && response.statusCode == 200) {
//       if (response.data['status'] == 1) {
//         contactList.clear();
//         contactList.add(PurchaseMaterialGetData.fromJson(response.data));
//         EasyLoading.dismiss();
//       } else {
//         AppWidgets.toast(msg: ' ${response.data['message']}#1');
//         EasyLoading.dismiss();
//       }
//     }
//   }
//
//   Future<void> getSingleData(String poId) async {
//     var response = await ApiServices().apiService({'po_id': poId}, ApiUrls.getSinglePO);
//     if (response != null && response.statusCode == 200) {
//       if (response.data['status'] == 1) {
//         singleDataList.clear();
//         singleDataList.add(PurchaseSingleData.fromJson(response.data));
//         EasyLoading.dismiss();
//         refreshScreen.value = Random().nextInt(9999999);
//       } else {
//         EasyLoading.dismiss();
//       }
//     }
//   }
//
//   Future<void> sendPOMail({required Map<String, dynamic> data}) async {
//     EasyLoading.show();
//     var response = await ApiServices().apiService(data, ApiUrls.sendPOMail);
//     if (response != null && response.statusCode == 200) {
//       if (response.data['status'] == 1) {
//         EasyLoading.dismiss();
//         AppWidgets.toast(msg: response.data['message']);
//       } else {
//         EasyLoading.dismiss();
//         AppWidgets.toast(msg: response.data['message']);
//       }
//     } else {
//       EasyLoading.dismiss();
//       AppWidgets.toast(msg: 'Something went wrong!!');
//     }
//   }
//
//   Future<dynamic> imagePickerDialogue(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: AppColors.white,
//           surfaceTintColor: AppColors.white,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
//           title: AppWidgets.snText(text: "Select Image Source", style: AppFonts.black16.copyWith(fontSize: 16.sp)),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 contentPadding: const EdgeInsets.all(0),
//                 leading: const Icon(Iconsax.camera, color: AppColors.lightblue),
//                 title: AppWidgets.snText(text: "Camera", style: AppFonts.black16.copyWith(fontSize: 15.sp)),
//                 onTap: () {
//                   pickImages(false);
//                   refreshImagesChange.value = Random().nextInt(9999999);
//                   Get.back();
//                 },
//               ),
//               ListTile(
//                 contentPadding: const EdgeInsets.all(0),
//                 leading: const Icon(Iconsax.gallery, color: AppColors.lightblue),
//                 title: AppWidgets.snText(text: "Gallery", style: AppFonts.black16.copyWith(fontSize: 15.sp)),
//                 onTap: () {
//                   pickImages(true);
//                   refreshImagesChange.value = Random().nextInt(9999999);
//                   Get.back();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
