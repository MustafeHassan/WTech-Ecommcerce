import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:wtech_dashboard/core/theme/colors.dart';
import 'package:wtech_dashboard/core/validators/forgot_password_form_group.dart';
import 'package:wtech_dashboard/core/widgets/button.dart';
import 'package:wtech_dashboard/core/widgets/r_text_field.dart';

import '../../../../core/routes/app_routes.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: AppColor.white,
      body: Column(
        children: [
          const Spacer(),
          Image.asset(
            'assets/images/logo.png',
            width: 100,
          ),
          const Spacer(),
          Center(
            child: Container(
              width: 400,
              height: 350,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColor.captionColor.withOpacity(0.3),
                    blurRadius: 15.0,
                    blurStyle: BlurStyle.outer,
                    spreadRadius: 20.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(5),
                color: AppColor.white,
              ),
              child: ReactiveForm(
                formGroup: forgotPassword,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RESET PASSWORD',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 10),
                      RTextFormField(
                        prefix: const Icon(Icons.person),
                        controllerName: 'Email',
                        label: 'Email Address',
                        validationMessages: emailValidatorForgotPassword(),
                      ),
                      const SizedBox(height: 15),
                      CustomButtonConsumer(
                        width: MediaQuery.of(context).size.width,
                        onPressed: () {
                          context.goNamed(emailSentScreen);
                        },
                        text: 'SEND RESET LINK',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
