// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:get/get.dart';
// import 'package:sme/utils/appcolor.dart';
// import 'package:sme/utils/appwidgets.dart';
// import 'package:sme/utils/apputils.dart';
// import 'AddSiteDiary.dart';
// import 'new_sitediaries_logic.dart';
// import 'widgets/new_sitediaries_widgets.dart';
//
// class SiteDiaryView extends StatefulWidget {
//   const SiteDiaryView({super.key});
//
//   @override
//   State<SiteDiaryView> createState() => _SiteDiaryViewState();
// }
//
// class _SiteDiaryViewState extends State<SiteDiaryView> {
//   SiteDiaryController siteDiaryController = Get.put(SiteDiaryController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           AppWidgets.background(),
//           Column(
//             children: [
//               AppWidgets.commonAppBar(
//                 title: 'Site Diaries',
//                 addVisible: true,
//                 onTap: () {
//                   AppUtils().playAudio(audioPlayer: AppWidgets.audioPlayer);
//                   Get.to(() => const AddSiteDiary(isEdit: false));
//                 },
//               ),
//
//               AppWidgets.underDevelopment(),
//               Expanded(
//                 child: Obx(() {
//                   return !siteDiaryController.isLoading.value
//                       ? siteDiaryController.siteDiariesList.isEmpty
//                           ? AppWidgets.noData()
//                           : RefreshIndicator(
//                               color: AppColors.lightBlue,
//                               backgroundColor: AppColors.white,
//                               onRefresh: () async => await siteDiaryController.getSiteDiaryData(),
//                               child: ListView.builder(
//                                 itemCount: siteDiaryController.siteDiariesList.length,
//                                 padding: const EdgeInsets.all(0),
//                                 itemBuilder: (context, index) {
//                                   return GestureDetector(
//                                     onTap: () async {
//                                       AppUtils().playAudio(audioPlayer: AppWidgets.audioPlayer);
//                                       String siteDiaryId = siteDiaryController.siteDiariesList[index].id;
//                                       await siteDiaryController.getSingleSiteDiaryDetail(siteDiaryId: siteDiaryId);
//                                     },
//                                     child: AppWidgets.siteDiariesItem(
//                                       siteId: siteDiaryController.siteDiariesList[index].jobNo,
//                                       siteAddress: siteDiaryController.siteDiariesList[index].siteAddress,
//                                       date: siteDiaryController.siteDiariesList[index].date,
//                                       name: siteDiaryController.siteDiariesList[index].name,
//                                       status: siteDiaryController.siteDiariesList[index].statusName,
//                                     ).animate(
//                                       effects: [
//                                         SlideEffect(
//                                           duration: const Duration(milliseconds: 600),
//                                           curve: Curves.easeOutQuad,
//                                           delay: const Duration(milliseconds: 100),
//                                           begin: Offset(index.isEven ? 1 : -1, 0),
//                                           end: Offset.zero,
//                                         ),
//                                         const FadeEffect(
//                                           duration: Duration(milliseconds: 600),
//                                           delay: Duration(milliseconds: 100),
//                                           curve: Curves.easeOutQuad,
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               ),
//                             )
//                       : NewSiteDiariesWidgets.siteDiariesSkeletonizer();
//                 }),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
