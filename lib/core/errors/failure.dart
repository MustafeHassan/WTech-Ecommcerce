import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  final String failureMessage = 'Please check your internet connection';
  @override
  List<Object?> get props => [failureMessage];
}

class OtpCodeSendFailure extends Failure {
  final String failureMessage = 'Could not send otp code, try later';
  @override
  List<Object?> get props => [failureMessage];
}

class EmailNotExist extends Failure {
  final String failureMessage = 'The email address is not exit';

  @override
  List<Object?> get props => [failureMessage];
}

class FacebookLoginFailure extends Failure {
  final String failureMessage =
      'Can\'t not sign in with facebook because email already in use ';

  @override
  List<Object?> get props => [failureMessage];
}

class NullSafetyFailure extends Failure {
  final String failureMessage = 'Something went wrong - try agian later';
  @override
  List<Object?> get props => [failureMessage];
}

class VerificationCodeFailure extends Failure {
  final String failureMessage = 'The verification code is invalid!';

  @override
  List<Object?> get props => [failureMessage];
}

class SignInFailure extends Failure {
  final String failureMessage = 'The email or password is wrong';

  @override
  List<Object?> get props => [failureMessage];
}

class UserNotLoggedInFailure extends Failure {
  final String failureMessage = 'You are not logged in';

  @override
  List<Object?> get props => [failureMessage];
}

class UserNotVerifiedFailure extends Failure {
  final String failureMessage = 'Your account is not verified';

  @override
  List<Object?> get props => [failureMessage];
}

class NoDataFoundFailure extends Failure {
  final String failureMessage = 'Nothing found Unfortunately!';

  @override
  List<Object?> get props => [failureMessage];
}

class UnexpectedErrorFailure extends Failure {
  final String failureMessage = 'Unexpected error occured - try later';

  @override
  List<Object?> get props => [failureMessage];
}

class ProductAlreadyExistFailure extends Failure {
  final String failureMessage = 'you already added it to favorites';

  @override
  List<Object?> get props => [failureMessage];
}
