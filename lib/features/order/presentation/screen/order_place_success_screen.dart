import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import 'package:wtech_ecommerce/core/theme/animations_asset.dart';
import 'package:wtech_ecommerce/core/theme/theme.dart';

import '../../../../core/routes/app_route.dart';

class OrderPlaceSuccessScreen extends StatelessWidget {
  const OrderPlaceSuccessScreen({
    Key? key,
    required this.orderId,
  }) : super(key: key);
  final String orderId;
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
                success,
                width: 180.w,
                height: 180.h,
                repeat: true,
              ),
              SizedBox(height: 15.h),
              Text(
                'Order placed',
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(height: 15.h),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Text(
                  'Your order $orderId was placed with success.\n You can see the status of the order at any time.',
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => context.goNamed(orderStatusScreen),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    AppTheme.primaryColor.withOpacity(0.5),
                  ),
                ),
                child: Text(
                  'SEE ORDER STATUS',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
              SizedBox(height: 5.h),
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
