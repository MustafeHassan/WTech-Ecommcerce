import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/theme.dart';

void showWarningGoogle(BuildContext context, VoidCallback onPressed) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Column(
          children: [
            CircleAvatar(
              radius: 30.r,
              child: Icon(
                Icons.dangerous,
                color: AppTheme.white,
                size: 40,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Warning!',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
        content: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            text: 'If you sign in with ',
            style: Theme.of(context).textTheme.bodyText1,
            children: [
              TextSpan(
                text: 'Google!',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppTheme.red,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextSpan(
                text: '\n your previous account created with',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              TextSpan(
                text: ' @gmail.com ',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppTheme.red,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextSpan(
                text:
                    'email will be removed and replaced with this sign in method\n ',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              TextSpan(
                text:
                    'you won\'t be able sign in or create account with previous email again!',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: onPressed,
            child: const Text('SIGN IN'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('CANCEL'),
          ),
        ],
      );
    },
  );
}
