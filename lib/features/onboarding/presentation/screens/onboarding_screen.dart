import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wtech_ecommerce/services_locator.dart';
import 'package:wtech_ecommerce/features/onboarding/presentation/widgets/page_indicator_widget.dart';

import '../../../../core/routes/app_route.dart';
import 'pages/onboarding_1_page.dart';
import 'pages/onboarding_2_page.dart';
import 'pages/onboarding_3_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final ValueNotifier<int> _pageIndex = ValueNotifier(0);
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: _pageIndex,
            builder: (context, pageIndex, child) {
              return Column(
                children: [
                  SizedBox(height: 60.h),
                  PageIndicatorWidget(pageIndex: _pageIndex.value),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (int index) {
                        _pageIndex.value = index;
                      },
                      children: [
                        Onboarding1(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                        Onboarding2(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                        Onboarding3(
                          goToSignUp: () {
                            preferences.setBool('onBoarding', true);
                            debugPrint(
                                '------------SharedPreferences for Onboarding Screen is being set--------------');

                            context.replaceNamed(signUpScreen);
                          },
                          goToSignIn: () {
                            preferences.setBool('onBoarding', true);
                            debugPrint(
                                '------------SharedPreferences for Onboarding Screen is being set--------------');

                            context.replaceNamed(signInScreen);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
