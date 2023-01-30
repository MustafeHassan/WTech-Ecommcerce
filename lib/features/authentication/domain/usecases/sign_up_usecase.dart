// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/features/authentication/domain/entities/user_entity.dart';
import 'package:wtech_ecommerce/features/authentication/domain/repositories/auth_repository.dart';

import '../../../../core/errors/failure.dart';

class SignUpUseCase {
  final AuthRepository authRepository;
  SignUpUseCase({
    required this.authRepository,
  });

  Future<Either<Failure, UserE>> call({
    required String email,
    required String password,
    required String userName,
    required String phoneNumber,
  }) async {
    return await authRepository.signUpWithEmailAndPassword(
      email: email,
      password: password,
      userName: userName,
      phoneNumber: phoneNumber,
    );
  }
}
