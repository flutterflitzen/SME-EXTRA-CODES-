// import 'package:flutter/material.dart';
// import 'package:skeletonizer/skeletonizer.dart';
// import 'package:sme/utils/appwidgets.dart';
//
// class NewSiteDiariesWidgets{
//   static ListView siteDiariesSkeletonizer() {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: 10,
//       padding: const EdgeInsets.all(0),
//       itemBuilder: (context, index) {
//         return Skeletonizer(
//           child: AppWidgets.siteDiariesItem(
//             siteId: '00000',
//             date: '00000 00 0 000 0',
//             name: 'SME',
//             siteAddress: 'SME',
//             status: 'SME',
//           ),
//         );
//       },
//     );
//   }
// }
//
// //import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:sme/utils/appcolor.dart';
// // import 'package:sme/utils/appwidgets.dart';
// // import 'package:sme/utils/apputils.dart';
// // import 'oldcode/AddSiteDiary.dart';
// // import 'oldcode/new_sitediaries_logic.dart';
// // import 'widgets/new_sitediaries_widgets.dart';
// //
// // class SiteDiary extends StatefulWidget {
// //   const SiteDiary({super.key});
// //
// //   @override
// //   State<SiteDiary> createState() => _SiteDiaryState();
// // }
// //
// // class _SiteDiaryState extends State<SiteDiary> with SingleTickerProviderStateMixin {
// //   SiteDiaryController siteDiaryController = Get.put(SiteDiaryController());
// //   late TabController _tabController;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _tabController = TabController(length: 3, vsync: this);
// //   }
// //
// //   @override
// //   void dispose() {
// //     _tabController.dispose();
// //     super.dispose();
// //   }
// //
// //   Widget _buildSiteDiaryList(List<dynamic> items, bool isLoading) {
// //     return isLoading
// //         ? items.isEmpty
// //             ? AppWidgets.noData()
// //             : RefreshIndicator(
// //                 color: AppColors.lightblue,
// //                 backgroundColor: AppColors.white,
// //                 onRefresh: () async {
// //                   siteDiaryController.siteDiaryDraftList.clear();
// //                   siteDiaryController.siteDiaryReviewedList.clear();
// //                   siteDiaryController.siteDiaryApprovedList.clear();
// //                   await Future.delayed(const Duration(seconds: 1));
// //                   await siteDiaryController.getDraftSiteDiaryData().whenComplete(() => siteDiaryController.getReviewSiteDiaryData().whenComplete(() => siteDiaryController.getApprovedSiteData()));
// //                 },
// //                 child: ListView.builder(
// //                   itemCount: items.length,
// //                   padding: const EdgeInsets.all(0),
// //                   itemBuilder: (context, index) {
// //                     return GestureDetector(
// //                       onTap: () async {
// //                         AppUtils().playAudio(audioPlayer: AppWidgets.audioPlayer);
// //                         if (kDebugMode) {
// //                           print('diaryId===>${items[index].id}');
// //                         }
// //                         await siteDiaryController.getSingleSiteDiaryDetail(items[index].id);
// //                         Get.to(
// //                           () => const AddSiteDiary(isEdit: true),
// //                         );
// //                       },
// //                       child: AppWidgets.siteDiariesItem(
// //                         siteId: '${items[index].jobNo}',
// //                         siteAddress: '${items[index].siteAddress}',
// //                         date: '${items[index].date}',
// //                         name: '${items[index].name}',
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               )
// //         : NewSiteDiariesWidgets.siteDiariesSkeletonizer();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Stack(
// //         children: [
// //           AppWidgets.background(),
// //           GetX<SiteDiaryController>(
// //             builder: (controller) {
// //               return Column(
// //                 children: [
// //                   AppWidgets.commonAppBar(
// //                     title: 'Site Diaries',
// //                     addVisible: true,
// //                     onTap: () {
// //                       AppUtils().playAudio(audioPlayer: AppWidgets.audioPlayer);
// //                       Get.to(() => const AddSiteDiary(isEdit: false));
// //                     },
// //                   ),
// //                   TabBar(
// //                     controller: _tabController,
// //                     labelColor: AppColors.lightblue,
// //                     unselectedLabelColor: Colors.grey,
// //                     indicatorColor: AppColors.lightblue,
// //                     tabs: [
// //                       Tab(
// //                         text: 'Draft (${controller.totalDraft})',
// //                       ),
// //                       Tab(
// //                         text: 'Review (${controller.totalReview})',
// //                       ),
// //                       Tab(
// //                         text: 'Approved (${controller.totalApproved})',
// //                       ),
// //                     ],
// //                   ),
// //                   Expanded(
// //                     child: TabBarView(
// //                       controller: _tabController,
// //                       children: [
// //                         _buildSiteDiaryList(controller.siteDiaryDraftList, controller.isLoading.value),
// //                         _buildSiteDiaryList(controller.siteDiaryReviewedList, controller.isLoading.value),
// //                         _buildSiteDiaryList(controller.siteDiaryApprovedList, controller.isLoading.value),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               );
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }