// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lottie/lottie.dart';
// import 'package:sme/api/apiservice.dart';
// import 'package:sme/api/apiurl.dart';
// import 'package:sme/app/login/login_view.dart';
// import 'package:sme/app/user/sitediaries/AddSiteDiary.dart';
// import 'package:sme/app/user/sitediaries/model/sitediaries_model.dart';
// import 'package:sme/utils/appcolor.dart';
// import 'package:sme/utils/appimages.dart';
// import 'package:sme/utils/appwidgets.dart';
// import 'package:http/http.dart' as http;
//
// class SiteDiaryController extends GetxController {
//   RxList<SiteDiaryDataModel> siteDiariesList = <SiteDiaryDataModel>[].obs;
//   RxList<SiteDiaryDataModel> singleSiteDiary = <SiteDiaryDataModel>[].obs;
//
//   RxBool isLoading = false.obs;
//
//   RxList<XFile> selectedImages = <XFile>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     getSiteDiaryData();
//   }
//
//   ValueNotifier<int> refreshImagesChange = ValueNotifier(0);
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
//   Future<void> getSiteDiaryData() async {
//     siteDiariesList.clear();
//     isLoading.value = true;
//     var response = await ApiServices().apiService({}, ApiUrls.getSiteDiary);
//     if (response != null && response.statusCode == 200) {
//       if (response.data['status'] == 1) {
//         siteDiariesList.clear();
//         for (var i in response.data['data']) {
//           siteDiariesList.add(SiteDiaryDataModel.fromJson(i));
//         }
//         isLoading.value = false;
//       } else if (response.data['status'] == 'access_token_error') {
//         Get.offAll(() => LoginView());
//         AppWidgets.toast(msg: 'Your Login Session has Expired');
//       } else {}
//     } else {
//       AppWidgets.toast(msg: 'Something Went Wrong!${response?.data['message']}');
//     }
//   }
//
//   Future<void> addSiteDiaryData(Map<String, dynamic> data, {bool isEdit = false}) async {
//     EasyLoading.show(indicator: Lottie.asset(AppImages.loading, fit: BoxFit.fitHeight, height: 100, width: 100));
//     var request = http.MultipartRequest('Post', isEdit ? Uri.parse(ApiUrls.editSiteDiary) : Uri.parse(ApiUrls.addSiteDiary));
//     data.forEach((key, value) {
//       request.fields[key] = value.toString();
//     });
//     if (selectedImages.isNotEmpty) {
//       for (int i = 0; i < selectedImages.length; i++) {
//         File imageFile = File(selectedImages[i].path);
//         if (await imageFile.exists()) {
//           debugPrint('Adding image: ${imageFile.path}');
//           request.files.add(
//             await http.MultipartFile.fromPath(
//               'attachments[$i]',
//               selectedImages[i].path,
//             ),
//           );
//         } else {
//           debugPrint('Image does not exist: ${imageFile.path}');
//         }
//       }
//     }
//     var response = await request.send();
//     if (response.statusCode == 200) {
//       var responseData = await http.Response.fromStream(response);
//       var decodedResponse = jsonDecode(responseData.body);
//       if (decodedResponse['status'] == 1) {
//         onInit();
//         Get.back();
//         AppWidgets.toast(msg: 'SiteDiary ${decodedResponse['message']}', backgroundColor: AppColors.green);
//         EasyLoading.dismiss();
//       } else if (decodedResponse.data['status'] == 'access_token_error') {
//         Get.offAll(() => LoginView());
//         AppWidgets.toast(msg: 'Your Login Session has Expired');
//         EasyLoading.dismiss();
//       } else {
//         AppWidgets.toast(msg: ' ${decodedResponse.data['message']}#4');
//         EasyLoading.dismiss();
//       }
//     } else {
//       AppWidgets.toast(msg: 'Something Went Wrong!${response.statusCode}');
//       EasyLoading.dismiss();
//     }
//   }
//
//   Future<void> getSingleSiteDiaryDetail({required String siteDiaryId}) async {
//     debugPrint('SiteDiaryId: $siteDiaryId');
//     singleSiteDiary.clear();
//     EasyLoading.show();
//     final response = await ApiServices().apiService({'site_diary_id': siteDiaryId}, ApiUrls.singleSiteDiary).whenComplete(() => EasyLoading.dismiss());
//     if (response != null && response.statusCode == 200) {
//       if (response.data['status'] == 1) {
//         EasyLoading.dismiss();
//         for (var i in response.data['data']) {
//           singleSiteDiary.add(SiteDiaryDataModel.fromJson(i));
//         }
//         Get.to(() => const AddSiteDiary(isEdit: true));
//       } else if (response.data['status'] == 'access_token_error') {
//         EasyLoading.dismiss();
//         Get.offAll(() => LoginView());
//         AppWidgets.toast(msg: 'Your Login Session has Expired');
//       }
//     } else {
//       EasyLoading.dismiss();
//       AppWidgets.toast(msg: response?.data['message'], backgroundColor: AppColors.red);
//     }
//   }
// }
