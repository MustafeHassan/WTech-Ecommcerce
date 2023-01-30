import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:wtech_ecommerce/features/onboarding/onboarding_data.dart';

import '../../../../../core/theme/theme.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({
    Key? key,
    this.goToSignIn,
    this.goToSignUp,
  }) : super(key: key);
  final VoidCallback? goToSignIn, goToSignUp;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: Column(
        children: [
          DelayedDisplay(
            fadingDuration: const Duration(seconds: 1),
            slidingCurve: Curves.ease,
            slidingBeginOffset: const Offset(0.0, 0.8),
            child: SvgPicture.asset(onboardingData[2]['image'],
                width: 402.w, height: 402.w),
          ),
          DelayedDisplay(
            fadingDuration: const Duration(seconds: 2),
            slidingCurve: Curves.ease,
            slidingBeginOffset: const Offset(0.0, 0.8),
            child: Text(
              onboardingData[2]['subTitle'],
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppTheme.white,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          DelayedDisplay(
            fadingDuration: const Duration(seconds: 3),
            slidingCurve: Curves.ease,
            slidingBeginOffset: const Offset(0.0, 0.8),
            child: Text(
              onboardingData[2]['title'],
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: AppTheme.white,
                    fontWeight: FontWeight.w100,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: goToSignIn,
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                BorderSide(color: AppTheme.borderColor),
              ),
            ),
            child: Text(
              'SIGN IN',
              style: Theme.of(context).textTheme.button,
            ),
          ),
          SizedBox(height: 10.h),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppTheme.blue),
            ),
            onPressed: goToSignUp,
            child: Text(
              'CREATE ACCOUNT',
              style: Theme.of(context).textTheme.button,
            ),
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}
