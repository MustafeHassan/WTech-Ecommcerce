// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/features/authentication/domain/repositories/auth_repository.dart';

import '../../../../core/errors/failure.dart';
import '../entities/user_entity.dart';

class SignInWithEmailAndPasswordUseCase {
  final AuthRepository authRepository;
  SignInWithEmailAndPasswordUseCase({
    required this.authRepository,
  });

  Future<Either<Failure, UserE>> call(
      {required String email, required String password}) async {
    return await authRepository.signInWithEmailAndPassword(
        email: email, password: password);
  }
}
