import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theme/theme.dart';
import '../../../onboarding_data.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({
    Key? key,
    this.onPressed,
  }) : super(key: key);
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: Column(
        children: [
          SizedBox(height: 60.h),
          DelayedDisplay(
            fadingDuration: const Duration(seconds: 3),
            slidingCurve: Curves.ease,
            slidingBeginOffset: const Offset(0.0, 0.8),
            child: Text(
              onboardingData[1]['subTitle'],
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppTheme.white,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15.sp),
          DelayedDisplay(
            fadingDuration: const Duration(seconds: 2),
            slidingCurve: Curves.ease,
            slidingBeginOffset: const Offset(0.0, 0.8),
            child: Text(
              onboardingData[1]['title'],
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: AppTheme.white,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          DelayedDisplay(
            fadingDuration: const Duration(seconds: 1),
            slidingCurve: Curves.ease,
            slidingBeginOffset: const Offset(0.0, 0.8),
            child: SvgPicture.asset(onboardingData[1]['image'],
                width: 378.w, height: 378.w),
          ),
          const Spacer(),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppTheme.blue),
            ),
            onPressed: onPressed,
            child: Text(
              'NEXT',
              style: Theme.of(context).textTheme.button,
            ),
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}
