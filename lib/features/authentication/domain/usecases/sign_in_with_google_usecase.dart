import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/features/authentication/domain/repositories/auth_repository.dart';

import '../../../../core/errors/failure.dart';
import '../entities/user_entity.dart';

class SignInWithGoogleUsecase {
  final AuthRepository authRepository;
  SignInWithGoogleUsecase({
    required this.authRepository,
  });

  Future<Either<Failure, UserE>> call() async {
    return await authRepository.signInWithGoogle();
  }
}
