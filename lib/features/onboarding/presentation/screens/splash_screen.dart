import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';
import 'package:wtech_ecommerce/core/theme/theme.dart';
import '../../../../core/routes/app_route.dart';

import '../../../../services_locator.dart' as di;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), (() {})).then(
      (value) {
        if (di.preferences.getBool('onBoarding') == true) {
          if ((di.preferences.getBool('LoggedIn') != null ||
              di.preferences.getBool('Registered') != null)) {
            context.replaceNamed(storeScreen);
          } else {
            context.replaceNamed(signInScreen);
          }
        } else {
          context.replaceNamed(introductionScreen);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/splash.png',
              width: 140.w,
            ),
          ],
        ),
      ),
    );
  }
}
