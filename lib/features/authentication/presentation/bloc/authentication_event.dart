// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignInWithEmailAndPasswordRequested extends AuthenticationEvent {
  final String email;
  final String password;

  const SignInWithEmailAndPasswordRequested(
      {required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class SignUpWithEmailAndPasswordRequested extends AuthenticationEvent {
  final String email;
  final String password;
  final String userName;
  final String phoneNumber;

  const SignUpWithEmailAndPasswordRequested({
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [email, password, userName, phoneNumber];
}

class SignInWithFacebookRequested extends AuthenticationEvent {
  const SignInWithFacebookRequested();
  @override
  List<Object> get props => [];
}

class SignInWithGoogleRequested extends AuthenticationEvent {
  const SignInWithGoogleRequested();
  @override
  List<Object> get props => [];
}

class VerifiedOtpCode extends AuthenticationEvent {
  final String email;
  final String otpCode;
  const VerifiedOtpCode({required this.email, required this.otpCode});
  @override
  List<Object> get props => [email, otpCode];
}

class UserStatusAuthenticationChecked extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class SignedOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class SentOtpCode extends AuthenticationEvent {
  final String email;
  const SentOtpCode({
    required this.email,
  });
  @override
  List<Object> get props => [email];
}
