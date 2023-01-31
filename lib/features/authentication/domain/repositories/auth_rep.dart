import 'package:dartz/dartz.dart';
import 'package:wtech_dashboard/core/errors/failure.dart';

import '../entities/admin_entity.dart';

abstract class AuthRepo {
  Future<Either<AdminE, Failure>> logIn(
      {required String email, required String password});
  Future<Either<Unit, Failure>> forgotPassword({required String email});
}
