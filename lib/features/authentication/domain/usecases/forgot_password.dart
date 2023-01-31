// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wtech_dashboard/core/errors/failure.dart';
import 'package:wtech_dashboard/features/authentication/domain/repositories/auth_rep.dart';

class ForgotPasswordUsecase {
  final AuthRepo authRepo;
  ForgotPasswordUsecase({
    required this.authRepo,
  });
  Future<Either<Unit, Failure>> call({required String email}) async {
    return await authRepo.forgotPassword(
      email: email,
    );
  }
}
