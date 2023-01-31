// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wtech_dashboard/core/errors/failure.dart';

import 'package:wtech_dashboard/features/authentication/domain/entities/admin_entity.dart';
import 'package:wtech_dashboard/features/authentication/domain/usecases/forgot_password.dart';
import 'package:wtech_dashboard/service_locator.dart' as di;

import '../../domain/usecases/login_usecase.dart';

part 'authenticaation_state.dart';

class AuthenticaationCubit extends Cubit<AuthenticaationState> {
  final LogInUsecase login;
  final ForgotPasswordUsecase forgotPassword;
  AuthenticaationCubit({
    required this.login,
    required this.forgotPassword,
  }) : super(AuthenticaationInitial());

  void logInCubit({required String email, required String password}) async {
    emit(AuthenticaationLoading());
    var either = await login.call(email: email, password: password);
    either.fold((l) async {
      di.preferences.setBool('isLoggedIn', true);
      debugPrint('isLoggedIn Set');
      emit(AuthenticaationSuccess(adminE: l));
    }, (r) {
      if (r is SignInFailure) {
        emit(AuthenticaationError(error: r.failureMessage));
      }
      if (r is OfflineFailure) {
        emit(AuthenticaationError(error: r.failureMessage));
      }
      if (r is UnexpectedErrorFailure) {
        emit(AuthenticaationError(error: r.failureMessage));
      }
    });
  }

  void forgotPasswordCubit({required String email}) async {
    emit(AuthenticaationLoading());
    var either = await forgotPassword.call(email: email);
    either.fold((l) async {
      emit(PasswordResestSuccess());
    }, (r) {
      if (r is EmailNotExist) {
        emit(AuthenticaationError(error: r.failureMessage));
      }
      if (r is OfflineFailure) {
        emit(AuthenticaationError(error: r.failureMessage));
      }
      if (r is UnexpectedErrorFailure) {
        emit(AuthenticaationError(error: r.failureMessage));
      }
    });
  }
}
