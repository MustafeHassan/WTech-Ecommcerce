// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/features/favorites/domain/repositories/favorites_repository.dart';

import '../../../../core/errors/failure.dart';

class RemoveProductFromFavoritesUsecase {
  final FavoritesRepository repository;
  RemoveProductFromFavoritesUsecase({
    required this.repository,
  });
  Future<Either<Failure, Unit>> call({required String id}) async {
    return await repository.removeProductToFavorites(id);
  }
}
