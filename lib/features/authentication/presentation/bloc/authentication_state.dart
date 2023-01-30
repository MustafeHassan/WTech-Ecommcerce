part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class UnAthenticatedState extends AuthenticationState {}

class LoadingState extends AuthenticationState {}

class ErrorState extends AuthenticationState {
  final String error;
  const ErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class VerifyOtpCodeState extends AuthenticationState {
  const VerifyOtpCodeState();
}

class UserVerifiedState extends AuthenticationState {
  const UserVerifiedState();
}

class AuthenticatedState extends AuthenticationState {
  final UserE userInfo;

  const AuthenticatedState({required this.userInfo});
}
