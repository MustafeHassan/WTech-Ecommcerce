import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/features/authentication/domain/entities/user_entity.dart';

import '../../../../core/errors/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserE>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserE>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String userName,
    required String phoneNumber,
  });

  Future<Either<Failure, UserE>> signInWithGoogle();
  Future<Either<Failure, UserE>> signInWithFacebook();

  Future<Either<Failure, Unit>> signOut();
}
