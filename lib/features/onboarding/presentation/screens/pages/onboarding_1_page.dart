import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wtech_ecommerce/features/onboarding/onboarding_data.dart';
import '../../../../../core/theme/theme.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({
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
          DelayedDisplay(
            fadingDuration: const Duration(milliseconds: 800),
            slidingCurve: Curves.ease,
            slidingBeginOffset: const Offset(0.0, 0.8),
            child: SvgPicture.asset(onboardingData[0]['image'],
                width: 406.w, height: 406.w),
          ),
          DelayedDisplay(
            fadingDuration: const Duration(seconds: 2),
            slidingCurve: Curves.ease,
            slidingBeginOffset: const Offset(0.0, 0.7),
            child: Text(
              onboardingData[0]['subTitle'],
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppTheme.white,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15.sp),
          DelayedDisplay(
            fadingDuration: const Duration(seconds: 3),
            slidingCurve: Curves.ease,
            slidingBeginOffset: const Offset(0.0, 0.8),
            child: Text(
              onboardingData[0]['title'],
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: AppTheme.white,
                  ),
              textAlign: TextAlign.center,
            ),
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
          SizedBox(height: 5.h),
        ],
      ),
    );
  }
}
