// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authenticaation_cubit.dart';

abstract class AuthenticaationState extends Equatable {
  const AuthenticaationState();

  @override
  List<Object> get props => [];
}

class AuthenticaationInitial extends AuthenticaationState {}

class AuthenticaationLoading extends AuthenticaationState {}

class PasswordResestSuccess extends AuthenticaationState {}

class AuthenticaationSuccess extends AuthenticaationState {
  final AdminE adminE;
  const AuthenticaationSuccess({
    required this.adminE,
  });
}

class AuthenticaationError extends AuthenticaationState {
  final String error;
  const AuthenticaationError({
    required this.error,
  });
}
