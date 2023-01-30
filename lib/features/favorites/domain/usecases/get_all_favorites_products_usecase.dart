// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/features/favorites/domain/repositories/favorites_repository.dart';

import '../../../../core/errors/failure.dart';
import '../entities/favorite_entity.dart';

class GetAllFavoriteProductsUsecase {
  final FavoritesRepository repository;
  GetAllFavoriteProductsUsecase({
    required this.repository,
  });
  Future<Either<Failure, List<FavoriteE>>> call() async {
    return await repository.getAllFavoriteProducts();
  }
}
