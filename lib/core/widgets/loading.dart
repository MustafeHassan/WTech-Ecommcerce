import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wtech_dashboard/core/theme/colors.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/loadingAnimation.json',
                width: 100,
                height: 100,
                repeat: true,
              ),
              const SizedBox(height: 15),
              Text(
                'LOADING',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColor.primaryColor,
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
