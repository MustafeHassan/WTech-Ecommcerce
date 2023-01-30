// ignore_for_file: prefer_void_to_null

import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/features/authentication/domain/repositories/auth_repository.dart';

import '../../../../core/errors/failure.dart';

class SignOutUscease {
  AuthRepository authRepository;
  SignOutUscease({
    required this.authRepository,
  });
  Future<Either<Failure, Unit>> call() async {
    return await authRepository.signOut();
  }
}
