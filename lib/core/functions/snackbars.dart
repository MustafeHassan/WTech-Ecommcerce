import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';

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
      duration: const Duration(seconds: 10),
      elevation: 1.3,
      dismissDirection: DismissDirection.horizontal,
      margin: const EdgeInsets.only(
        bottom: 15,
        left: 10,
        right: 10,
      ),
      backgroundColor: AppColor.white,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: statusColor,
          ),
          child: Icon(
            iconData,
            color: AppColor.white,
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
              color: AppColor.borderColor,
            ),
            const SizedBox(width: 6),
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
