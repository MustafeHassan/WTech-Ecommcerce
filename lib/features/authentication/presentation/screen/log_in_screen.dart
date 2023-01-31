import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:wtech_dashboard/admin_screen.dart';
import 'package:wtech_dashboard/core/functions/snackbars.dart';
import 'package:wtech_dashboard/core/routes/app_routes.dart';
import 'package:wtech_dashboard/core/theme/colors.dart';
import 'package:wtech_dashboard/core/validators/sign_in_form_group.dart';
import 'package:wtech_dashboard/core/widgets/button.dart';
import 'package:wtech_dashboard/core/widgets/r_password_text_field.dart';
import 'package:wtech_dashboard/core/widgets/r_text_field.dart';
import 'package:wtech_dashboard/features/authentication/presentation/cubit/authenticaation_cubit.dart';
import 'package:wtech_dashboard/features/dashboard/presentation/pages/desktop/dashboard_desktop.dart';

import '../widgets/remember_me.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});
  static final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(false);
  static final ValueNotifier<bool> _rememberMeStatus = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticaationCubit, AuthenticaationState>(
      listener: (context, state) {
        if (state is AuthenticaationError) {
          showSnackBar(
            context: context,
            iconData: Icons.error,
            title: state.error,
            statusColor: Colors.red,
          );
        }
        if (state is AuthenticaationSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const ShellAdminScree(
                child: DashboardPageDesktop(),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
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
                    formGroup: logInGroup,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOG IN',
                            style:
                                Theme.of(context).textTheme.headline3!.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                          ),
                          const SizedBox(height: 10),
                          RTextFormField(
                            prefix: const Icon(Icons.person),
                            controllerName: 'Email',
                            label: 'Email Address',
                            validationMessages: emailValidator(),
                          ),
                          const SizedBox(height: 10),
                          RPasswordTextField(
                            isPasswordVisible: _isPasswordVisible,
                            prefix: const Icon(Icons.lock),
                            validationMessage: passwordValidator(),
                          ),
                          const SizedBox(height: 10),
                          RememberMeWithForgotPassword(
                            onPressed: () {
                              context.pushNamed(forgotPasswordScreen);
                            },
                            rememberMeStatus: _rememberMeStatus,
                          ),
                          const SizedBox(height: 15),
                          CustomButtonConsumer(
                            width: MediaQuery.of(context).size.width,
                            onPressed: () {
                              BlocProvider.of<AuthenticaationCubit>(context)
                                  .logInCubit(
                                email: logInGroup
                                    .control('Email')
                                    .value
                                    .toString(),
                                password: logInGroup
                                    .control('Password')
                                    .value
                                    .toString(),
                              );
                            },
                            text: 'LOG IN',
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
      },
    );
  }
}
