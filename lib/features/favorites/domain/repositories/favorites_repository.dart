import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/core/errors/failure.dart';
import 'package:wtech_ecommerce/features/favorites/domain/entities/favorite_entity.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<FavoriteE>>> getAllFavoriteProducts();
  Future<Either<Failure, FavoriteE>> addProductToFavorites({
    required String id,
    required String name,
    required String category,
    required String imageUrl,
    required double price,
  });
  Future<Either<Failure, Unit>> removeProductToFavorites(String id);
}
