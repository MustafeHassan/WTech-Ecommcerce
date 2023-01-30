import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:wtech_ecommerce/core/theme/animations_asset.dart';
import 'package:wtech_ecommerce/core/theme/theme.dart';

import 'app_route.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

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
                pageNotFound,
                width: 180.w,
                height: 180.h,
                repeat: true,
              ),
              SizedBox(height: 15.h),
              Text(
                'Could Not Find The Page You Requested',
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => context.goNamed(storeScreen),
                child: Text(
                  'CONTINUE',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
