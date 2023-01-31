import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../theme/colors.dart';
import 'app_routes.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

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
              const Spacer(),
              Lottie.asset(
                pageNotFound,
                width: 180,
                height: 180,
                repeat: true,
              ),
              const SizedBox(height: 15.0),
              Text(
                'Could Not Find The Page You Requested',
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => context.goNamed(dashboardScreen),
                child: Text(
                  'CONTINUE',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
