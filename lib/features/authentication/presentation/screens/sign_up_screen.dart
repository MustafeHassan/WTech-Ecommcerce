// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:wtech_ecommerce/core/functions/snackbars.dart';
import 'package:wtech_ecommerce/core/routes/app_route.dart';
import 'package:wtech_ecommerce/core/theme/theme.dart';
import 'package:wtech_ecommerce/features/authentication/presentation/widgets/r_password_text_field.dart';
import 'package:wtech_ecommerce/features/authentication/presentation/widgets/r_text_field.dart';
import 'package:wtech_ecommerce/features/authentication/presentation/widgets/sign_in_or_sign_up_button.dart';

import '../../../../core/functions/exit_app_alert.dart';
import '../../../../core/validators/sign_in_and_sign_up_form_group.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/scaffold_body.dart';
import '../bloc/authentication_bloc.dart';
import '../widgets/facebook_button.dart';
import '../widgets/google_button.dart';
import '../widgets/warning_alert.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static final ValueNotifier<bool> isPasswordVisible = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => appExitAlert(context),
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is ErrorState) {
            showSnackBar(
              context: context,
              iconData: Icons.dangerous,
              title: state.error,
              statusColor: AppTheme.red,
            );
          } else if (state is AuthenticatedState) {
            signUpGroup.reset();
            context.goNamed(storeScreen);
          }
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Loading();
            } else {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  title: const Text(
                    'REGISTER',
                  ),
                ),
                body: ScaffoldBody(
                  child: ReactiveForm(
                    formGroup: signUpGroup,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 15.h),
                          Text(
                            'Create your account ',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(
                            'After your registration is complete,\n you can see out opportunity products ',
                            style: Theme.of(context).textTheme.caption!,
                            textAlign: TextAlign.center,
                          ),
                          RTextFormField(
                            controllerName: 'Username',
                            label: 'Username',
                            validationMessages: userNameValidator(),
                          ),
                          RTextFormField(
                            controllerName: 'Email',
                            label: 'Email',
                            validationMessages: emailValidator(),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          RPasswordTextField(
                            isPasswordVisible: isPasswordVisible,
                            validationMessage: passwordValidator(),
                          ),
                          RTextFormField(
                            controllerName: 'Phone',
                            label: 'Phone',
                            hintText: '+252063338746',
                            keyboardType: TextInputType.phone,
                            maxLength: 16,
                            validationMessages: phoneValidator(),
                          ),
                          SizedBox(height: 10.h),
                          SignInOrSignUpButtonConsumer(
                            signInOrSignUp: () {
                              context.read<AuthenticationBloc>().add(
                                    SignUpWithEmailAndPasswordRequested(
                                      email:
                                          signUpGroup.value['Email'].toString(),
                                      password: signUpGroup.value['Password']
                                          .toString(),
                                      phoneNumber:
                                          signUpGroup.value['Phone'].toString(),
                                      userName: signUpGroup.value['Username']
                                          .toString(),
                                    ),
                                  );
                            },
                            text: 'SIGN UP',
                          ),
                          SizedBox(height: 65.h),
                          GoogleButton(
                            onPressed: () {
                              showWarningGoogle(
                                context,
                                () {
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
                          SizedBox(height: 15.h),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text('Already have an account?',
                                  style: Theme.of(context).textTheme.caption),
                              TextButton(
                                onPressed: () {
                                  signUpGroup.reset();
                                  context.goNamed(signInScreen);
                                },
                                child: Text(
                                  'Sign In',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
