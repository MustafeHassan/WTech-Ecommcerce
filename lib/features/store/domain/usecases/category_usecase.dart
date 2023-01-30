// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/features/store/domain/repositories/store_repository.dart';

import '../../../../core/errors/failure.dart';
import '../entities/category_entity.dart';

class GetAllCategoriesUsecase {
  final StoreRepository storeRepository;
  GetAllCategoriesUsecase({
    required this.storeRepository,
  });
  Future<Either<Failure, List<CategoryE>>> call() async {
    return await storeRepository.getAllCategories();
  }
}
