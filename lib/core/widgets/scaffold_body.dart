// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../theme/theme.dart';

// class ScaffoldBody extends StatelessWidget {
//   const ScaffoldBody({
//     Key? key,
//     required this.child,
//     this.lessHight = false,
//     this.removePadding = false,
//   }) : super(key: key);
//   final Widget child;
//   final bool lessHight;
//   final bool removePadding;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: removePadding
//           ? EdgeInsets.zero
//           : EdgeInsets.symmetric(horizontal: 24.w),
//       margin: lessHight ? const EdgeInsets.only(top: 30) : EdgeInsets.zero,
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       decoration: BoxDecoration(
//         color: AppTheme.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20.r),
//           topRight: Radius.circular(20.r),
//         ),
//       ),
//       child: child,
//     );
//   }
// }
