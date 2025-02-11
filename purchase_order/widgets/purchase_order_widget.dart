// import 'package:flutter/material.dart';
// import 'package:skeletonizer/skeletonizer.dart';
//
// import '../../../../utils/appwidgets.dart';
//
// class PurchaseOrderWidget{
//    static Widget purchaseOrderShimmer() {
//     return Expanded(
//       child: ListView.builder(
//         padding: EdgeInsets.zero,
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return Skeletonizer(
//             child: AppWidgets.purchaseOrderCard(
//               date2: "",
//               status: "",
//               projectName: "",
//               poNumber: "",
//               jobNo: "",
//               price: "",
//             ),
//           );
//         },
//       ),
//     );
//   }
// }