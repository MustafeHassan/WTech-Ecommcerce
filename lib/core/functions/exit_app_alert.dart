import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/theme.dart';

Future<bool> appExitAlert(BuildContext context) async {
  showDialog(
    context: context,
    builder: ((_) {
      return AlertDialog(
        title: Column(
          children: [
            CircleAvatar(
              radius: 35.r,
              child: Icon(
                Icons.warning,
                color: AppTheme.white,
                size: 35,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Are you sure you want to exit!',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.w100,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  exit(0);
                },
                child: const Text(
                  'Yes',
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
            ],
          )
        ],
      );
    }),
  );
  return false;
}
