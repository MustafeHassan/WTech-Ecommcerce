// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wtech_dashboard/core/errors/exceptions.dart';

import 'package:wtech_dashboard/core/errors/failure.dart';
import 'package:wtech_dashboard/core/network/network_info.dart';
import 'package:wtech_dashboard/features/authentication/data/datasources/auth_data_source.dart';
import 'package:wtech_dashboard/features/authentication/domain/entities/admin_entity.dart';
import 'package:wtech_dashboard/features/authentication/domain/repositories/auth_rep.dart';

class AuthRepoImp implements AuthRepo {
  final NetworkInfo networkInfo;
  final AuthDataSource authDataSource;
  AuthRepoImp({
    required this.networkInfo,
    required this.authDataSource,
  });
  @override
  Future<Either<Unit, Failure>> forgotPassword({required String email}) async {
    if (await networkInfo.isConnectedToInternet) {
      try {
        await authDataSource.forgotPassword(email: email);
        return const Left(unit);
      } on UnexpectedErrorException {
        return Right(UnexpectedErrorFailure());
      }
    } else {
      return Right(OfflineFailure());
    }
  }

  @override
  Future<Either<AdminE, Failure>> logIn(
      {required String email, required String password}) async {
    try {
      var data = await authDataSource.logIn(email: email, password: password);
      return Left(data);
    } on UnexpectedErrorException {
      return Right(UnexpectedErrorFailure());
    } on SignInException {
      return Right(SignInFailure());
    }
  }
}
