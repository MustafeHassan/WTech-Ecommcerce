import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../theme/theme.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/loadingAnimation.json',
                width: 100.w,
                height: 100.h,
                repeat: true,
              ),
              SizedBox(height: 15.h),
              Text(
                'LOADING',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppTheme.primaryColor,
                      letterSpacing: 4,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
