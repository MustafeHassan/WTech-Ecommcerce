// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/features/store/domain/repositories/store_repository.dart';

import '../../../../core/errors/failure.dart';
import '../entities/products_entity.dart';

class GetAllProductsUsecase {
  final StoreRepository storeRepository;
  GetAllProductsUsecase({
    required this.storeRepository,
  });
  Future<Either<Failure, List<ProductsE>>> call() async {
    return await storeRepository.getAllProducts();
  }
}
