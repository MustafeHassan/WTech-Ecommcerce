// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:wtech_ecommerce/core/errors/failure.dart';
import 'package:wtech_ecommerce/features/favorites/domain/entities/favorite_entity.dart';
import 'package:wtech_ecommerce/features/favorites/domain/repositories/favorites_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../datasources/favorites_remote_data_source.dart';

class FavoritesRepositoryImp implements FavoritesRepository {
  final FavoriteRemoteDataSource dataSource;
  FavoritesRepositoryImp({
    required this.dataSource,
  });
  @override
  Future<Either<Failure, FavoriteE>> addProductToFavorites(
      {required String id,
      required String name,
      required String category,
      required String imageUrl,
      required double price}) async {
    try {
      var data = await dataSource.addProductToFavorites(
        id: id,
        name: name,
        category: category,
        imageUrl: imageUrl,
        price: price,
      );
      return Right(data);
    } on ProductAlreadyExistException {
      return Left(ProductAlreadyExistFailure());
    }
  }

  @override
  Future<Either<Failure, List<FavoriteE>>> getAllFavoriteProducts() async {
    try {
      var data = await dataSource.getAllFavoriteProducts();
      return Right(data);
    } on UnexpectedErrorException {
      return Left(UnexpectedErrorFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> removeProductToFavorites(String id) async {
    try {
      await dataSource.removeProductToFavorites(id: id);
      return const Right(unit);
    } on UnexpectedErrorException {
      return Left(UnexpectedErrorFailure());
    }
  }
}
