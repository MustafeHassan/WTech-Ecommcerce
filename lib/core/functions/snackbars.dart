import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/theme.dart';

void showSnackBar({
  required BuildContext context,
  required IconData iconData,
  required String title,
  required Color statusColor,
  bool isActionNeeded = false,
  VoidCallback? onPressed,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      action: isActionNeeded
          ? SnackBarAction(
              label: 'Verify',
              onPressed: onPressed!,
              textColor: AppTheme.primaryColor,
            )
          : null,
      duration: const Duration(seconds: 10),
      elevation: 1.3,
      dismissDirection: DismissDirection.horizontal,
      margin: EdgeInsets.only(
        bottom: 15,
        left: 10.w,
        right: 10.w,
      ),
      backgroundColor: AppTheme.white,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      content: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: statusColor,
          ),
          child: Icon(
            iconData,
            color: AppTheme.white,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              CupertinoIcons.time_solid,
              color: AppTheme.borderColor,
            ),
            SizedBox(width: 6.w),
            Text(
              'Just Now',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    ),
  );
}
