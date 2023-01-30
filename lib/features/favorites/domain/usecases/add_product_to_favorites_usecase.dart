// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/features/favorites/domain/repositories/favorites_repository.dart';

import '../../../../core/errors/failure.dart';
import '../entities/favorite_entity.dart';

class AddProductToFavoritesUsecase {
  final FavoritesRepository repository;
  AddProductToFavoritesUsecase({
    required this.repository,
  });
  Future<Either<Failure, FavoriteE>> call({
    required String id,
    required String name,
    required String category,
    required String imageUrl,
    required double price,
  }) async {
    return await repository.addProductToFavorites(
      id: id,
      name: name,
      category: category,
      imageUrl: imageUrl,
      price: price,
    );
  }
}
