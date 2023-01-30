// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:wtech_ecommerce/core/functions/snackbars.dart';
import 'package:wtech_ecommerce/core/routes/app_route.dart';
import 'package:wtech_ecommerce/core/theme/theme.dart';
import 'package:wtech_ecommerce/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:wtech_ecommerce/features/authentication/presentation/widgets/warning_alert.dart';

import '../../../../core/functions/exit_app_alert.dart';
import '../../../../core/validators/sign_in_and_sign_up_form_group.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/scaffold_body.dart';
import '../widgets/facebook_button.dart';
import '../widgets/google_button.dart';
import '../widgets/r_password_text_field.dart';
import '../widgets/remember_me.dart';
import '../widgets/sign_in_or_sign_up_button.dart';
import '../widgets/r_text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  static final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(true);
  static final ValueNotifier<bool> _rememberMeStatus = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => appExitAlert(context),
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            signInGroup.reset();
            context.goNamed(storeScreen);
          }
          if (state is ErrorState) {
            showSnackBar(
              context: context,
              iconData: Icons.dangerous,
              title: state.error,
              statusColor: AppTheme.red,
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Loading();
          } else {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Text(
                  'LOG IN',
                ),
              ),
              body: ScaffoldBody(
                child: ReactiveForm(
                  formGroup: signInGroup,
                  child: Column(
                    children: [
                      SizedBox(height: 15.h),
                      Text(
                        'Let\'s sign you in ',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        'Welcome back, you\'ve been missed! ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: AppTheme.borderColor),
                      ),
                      SizedBox(height: 25.h),
                      RTextFormField(
                        controllerName: 'Email',
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validationMessages: emailValidator(),
                      ),
                      RPasswordTextField(
                        isPasswordVisible: _isPasswordVisible,
                        validationMessage: signInPasswordValidator(),
                      ),
                      RememberMeWithForgotPassword(
                        rememberMeStatus: _rememberMeStatus,
                      ),
                      SignInOrSignUpButtonConsumer(
                        signInOrSignUp: () {
                          context.read<AuthenticationBloc>().add(
                                SignInWithEmailAndPasswordRequested(
                                  email: signInGroup.value['Email'].toString(),
                                  password:
                                      signInGroup.value['Password'].toString(),
                                ),
                              );
                        },
                        text: 'SIGN IN',
                      ),
                      const Spacer(),
                      GoogleButton(
                        onPressed: () async {
                          showWarningGoogle(
                            context,
                            () async {
                              Navigator.of(context).pop();
                              context
                                  .read<AuthenticationBloc>()
                                  .add(const SignInWithGoogleRequested());
                            },
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      FacebookButton(
                        onPressed: () async {
                          context
                              .read<AuthenticationBloc>()
                              .add(const SignInWithFacebookRequested());
                        },
                      ),
                      SizedBox(height: 10.h),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text('Don\'t have an account?',
                              style: Theme.of(context).textTheme.caption),
                          TextButton(
                            onPressed: () {
                              signInGroup.reset();
                              context.goNamed(signUpScreen);
                            },
                            child: Text(
                              'Sign Up',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
