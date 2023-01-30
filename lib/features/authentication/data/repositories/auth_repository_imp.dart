// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_void_to_null
import 'package:dartz/dartz.dart';

import 'package:wtech_ecommerce/core/errors/exceptions.dart';

import 'package:wtech_ecommerce/core/errors/failure.dart';
import 'package:wtech_ecommerce/core/network/network_info.dart';
import 'package:wtech_ecommerce/features/authentication/data/datasources/auth_remote_data_sources.dart';

import 'package:wtech_ecommerce/features/authentication/domain/entities/user_entity.dart';
import 'package:wtech_ecommerce/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  NetworkInfo networkInfo;
  AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImp({
    required this.networkInfo,
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<Failure, UserE>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    if (await networkInfo.isConnectedToInternet) {
      try {
        final userInfo = await authRemoteDataSource.signInWithEmailAndPassword(
            email: email, password: password);
        return Right(userInfo);
      } on SignInException {
        return Left(SignInFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, UserE>> signInWithFacebook() async {
    if (await networkInfo.isConnectedToInternet) {
      try {
        final userInfo = await authRemoteDataSource.signInWithFacebook();
        return Right(userInfo);
      } on FacebookLoginException {
        return Left(FacebookLoginFailure());
      } on NullSafetyException {
        return Left(NullSafetyFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, UserE>> signInWithGoogle() async {
    if (await networkInfo.isConnectedToInternet) {
      try {
        final userInfo = await authRemoteDataSource.signInWithGoogle();
        return Right(userInfo);
      } on UnexpectedErrorException {
        return Left(UnexpectedErrorFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, UserE>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String userName,
    required String phoneNumber,
  }) async {
    if (await networkInfo.isConnectedToInternet) {
      try {
        var data = await authRemoteDataSource.signUpWithEmailAndPassword(
            email: email,
            password: password,
            userName: userName,
            phoneNumber: phoneNumber);
        return Right(data);
      } on EmailAlreadyExistException {
        return Left(EmailAlreadyExistFailure());
      } on UnexpectedErrorException {
        return Left(UnexpectedErrorFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    if (await networkInfo.isConnectedToInternet) {
      try {
        await authRemoteDataSource.signOut();
        return const Right(unit);
      } on UnexpectedErrorException {
        return Left(UnexpectedErrorFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
