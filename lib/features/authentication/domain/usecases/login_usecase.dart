// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wtech_dashboard/core/errors/failure.dart';
import 'package:wtech_dashboard/features/authentication/domain/entities/admin_entity.dart';
import 'package:wtech_dashboard/features/authentication/domain/repositories/auth_rep.dart';

class LogInUsecase {
  final AuthRepo authRepo;
  LogInUsecase({
    required this.authRepo,
  });
  Future<Either<AdminE, Failure>> call(
      {required String email, required String password}) async {
    return await authRepo.logIn(email: email, password: password);
  }
}
