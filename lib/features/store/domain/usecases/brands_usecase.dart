import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/features/store/domain/entities/brands_entity.dart';
import 'package:wtech_ecommerce/features/store/domain/repositories/store_repository.dart';

import '../../../../core/errors/failure.dart';

class GetAllBrandsUsecase {
  final StoreRepository storeRepository;
  GetAllBrandsUsecase({
    required this.storeRepository,
  });
  Future<Either<Failure, List<BrandsE>>> call() async {
    return await storeRepository.getAllBrands();
  }
}
