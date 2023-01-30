import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:wtech_ecommerce/core/routes/app_route.dart';
import 'package:wtech_ecommerce/core/theme/animations_asset.dart';
import 'package:wtech_ecommerce/core/theme/theme.dart';

class EmailSentScreen extends StatelessWidget {
  const EmailSentScreen({
    Key? key,
  }) : super(key: key);

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
              const Spacer(),
              Lottie.asset(
                emailSent,
                width: 180.w,
                height: 180.h,
                repeat: true,
              ),
              SizedBox(height: 15.h),
              Text('Check Your Email',
                  style: Theme.of(context).textTheme.headline2),
              Text(
                'We\'ve sent you an instructions on how to reset password  your to mail address \n check your inbox or spam folder',
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  context.goNamed(signInScreen);
                },
                child: Text('CONTINUE'.toUpperCase(),
                    style: Theme.of(context).textTheme.button),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
