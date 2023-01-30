import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/app_icons.dart';

class DrawerOpen extends StatelessWidget {
  const DrawerOpen({Key? key, this.onTap}) : super(key: key);
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.r),
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Transform.scale(
        scaleX: 0.32.w,
        scaleY: 0.32.h,
        child: SvgPicture.asset(AppIcons.drawer),
      ),
    );
  }
}
