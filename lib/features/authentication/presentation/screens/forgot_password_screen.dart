// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:reactive_forms/reactive_forms.dart';
import 'package:wtech_ecommerce/core/errors/failure.dart';
import 'package:wtech_ecommerce/core/network/internet_connection_checker.dart';
import 'package:wtech_ecommerce/core/network/network_info.dart';
import 'package:wtech_ecommerce/core/theme/theme.dart';

import '../../../../core/functions/snackbars.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/validators/forgot_password_form_group.dart';
import '../../../../core/widgets/scaffold_body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.keyboard_backspace_outlined,
            color: AppTheme.white,
          ),
        ),
        title: const Text(
          'RESET PASSWORD',
        ),
      ),
      body: ScaffoldBody(
        child: ReactiveForm(
          formGroup: forgotPassword,
          child: Column(
            children: [
              SizedBox(height: 15.h),
              Text('Forgot your password?',
                  style: Theme.of(context).textTheme.headline2),
              Text(
                'Enter your email address and we will send you \n instructions on how to reset your password.',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: AppTheme.borderColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25.h),
              ReactiveTextField(
                formControlName: 'Email',
                validationMessages: emailValidator(),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                ),
              ),
              const Spacer(),
              ReactiveFormConsumer(builder: (context, formgGroup, _) {
                return ElevatedButton(
                  onPressed: formgGroup.valid
                      ? () async {
                          //! This is not recommended == becasue it breaks the priciple of clean architecture But I had to do this because of a mistake I made when I forgot to implement send Reset password email..

                          if (await NetworkInfoImp(
                            connectionChecker: InternetConnectionChecker(),
                          ).isConnectedToInternet) {
                            try {
                              formgGroup.controls['Email']!.unfocus();

                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(
                                email: formgGroup.value['Email'].toString(),
                              );
                              formgGroup.reset();
                              context.goNamed(emailSentScreen);
                            } on FirebaseAuthException catch (error) {
                              if (error.code == 'user-not-found') {
                                showSnackBar(
                                  context: context,
                                  iconData: Icons.dangerous,
                                  title: 'This email address does not exist',
                                  statusColor: AppTheme.red,
                                );
                              }
                            } catch (_) {
                              showSnackBar(
                                context: context,
                                iconData: Icons.dangerous,
                                title: 'Unexpected error occured, try later',
                                statusColor: AppTheme.red,
                              );
                            }
                          } else {
                            showSnackBar(
                              context: context,
                              iconData: Icons.dangerous,
                              title: OfflineFailure().failureMessage,
                              statusColor: AppTheme.red,
                            );
                          }
                        }
                      : null,
                  child: Text(
                    'SEND',
                    style: Theme.of(context).textTheme.button,
                  ),
                );
              }),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
