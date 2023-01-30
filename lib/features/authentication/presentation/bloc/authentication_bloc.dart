// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:wtech_ecommerce/core/errors/failure.dart';

import 'package:wtech_ecommerce/features/authentication/domain/entities/user_entity.dart';
import 'package:wtech_ecommerce/services_locator.dart' as di;

import 'package:wtech_ecommerce/features/authentication/domain/usecases/sign_in_facebook.dart';
import 'package:wtech_ecommerce/features/authentication/domain/usecases/sign_in_with_email_and_password_usecase.dart';
import 'package:wtech_ecommerce/features/authentication/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:wtech_ecommerce/features/authentication/domain/usecases/sign_out_usecase.dart';
import 'package:wtech_ecommerce/features/authentication/domain/usecases/sign_up_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SignInWithEmailAndPasswordUseCase signInWithEmail;
  final SignUpUseCase signUp;
  final SignInWithFacebookUseCase signInWithFacebook;
  final SignInWithGoogleUsecase signInWithGoogle;

  final SignOutUscease signout;

  AuthenticationBloc({
    required this.signInWithEmail,
    required this.signUp,
    required this.signInWithFacebook,
    required this.signInWithGoogle,
    required this.signout,
  }) : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is SignInWithEmailAndPasswordRequested) {
        emit(LoadingState());
        var failureOrData = await signInWithEmail.call(
            email: event.email, password: event.password);
        failureOrData.fold(
            (failure) => failureToStateMapper(
                  failure,
                  emit,
                ), (data) {
          successToStateMapper(data, emit, 'SignIn');
        });
      } else if (event is SignUpWithEmailAndPasswordRequested) {
        emit(LoadingState());
        var failureOrData = await signUp.call(
          email: event.email,
          password: event.password,
          userName: event.userName,
          phoneNumber: event.phoneNumber,
        );

        failureOrData.fold(
          (failure) => failureToStateMapper(
            failure,
            emit,
          ),
          (data) async {
            successToStateMapper(
              data,
              emit,
              'signUp',
            );
            await di.preferences.setBool('Registered', true);
          },
        );
      } else if (event is SignInWithFacebookRequested) {
        var failureOrData = await signInWithFacebook.call();
        failureOrData.fold(
          (failure) => failureToStateMapper(
            failure,
            emit,
          ),
          (data) => successToStateMapper(data, emit, 'Facebook'),
        );
      } else if (event is SignInWithGoogleRequested) {
        var failureOrData = await signInWithGoogle.call();
        failureOrData.fold(
          (failure) => failureToStateMapper(
            failure,
            emit,
          ),
          (data) => successToStateMapper(data, emit, 'Google'),
        );
      } else if (event is SignedOut) {
        emit(LoadingState());
        var failureOrData = await signout.call();
        failureOrData.fold(
            (failure) => failureToStateMapper(
                  failure,
                  emit,
                ), (data) async {
          successToStateMapper(data, emit, 'Signout');
        });
      }
    });
  }

  void successToStateMapper(Object data, Emitter<AuthenticationState> emit,
      [String? successType]) async {
    if (data is UserE && successType == 'SignIn' ||
        successType == 'Facebook' ||
        successType == 'Google' ||
        successType == 'signUp') {
      Map<String, dynamic> user = {
        'id': (data as UserE).userId,
        'profilePicture': (data).profilePicture,
        'email': data.email,
        'address': (data).address,
        'phoneNumber': (data).phoneNumber,
        'name': (data).userName,
      };
      emit(AuthenticatedState(userInfo: data));
      var userJson = jsonEncode(user);
      await di.preferences.setBool('LoggedIn', true);
      await di.preferences.setString('user', userJson);
    } else if (data is Unit && successType == 'Signout') {
      emit(LoadingState());
      emit(UnAthenticatedState());
      await Future.delayed(const Duration(seconds: 1), () {
        di.preferences.remove('user');
      });
    }
  }

  void failureToStateMapper(Failure failure, Emitter<AuthenticationState> emit,
      [AuthenticationEvent? event]) {
    if (failure is SignInFailure) {
      emit(ErrorState(error: failure.failureMessage));
    } else if (failure is EmailAlreadyExistFailure) {
      emit(ErrorState(error: failure.failureMessage));
    } else if (failure is FacebookLoginFailure) {
      emit(ErrorState(error: failure.failureMessage));
    } else if (failure is NullSafetyFailure) {
      debugPrint('User has cancelled sign in with facebook');
    } else if (failure is OfflineFailure) {
      emit(ErrorState(error: OfflineFailure().failureMessage));
    } else {
      emit(ErrorState(error: UnexpectedErrorFailure().failureMessage));
    }
  }
}
