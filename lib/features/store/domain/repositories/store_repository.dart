import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/core/errors/failure.dart';
import 'package:wtech_ecommerce/features/store/domain/entities/brands_entity.dart';
import 'package:wtech_ecommerce/features/store/domain/entities/category_entity.dart';
import 'package:wtech_ecommerce/features/store/domain/entities/products_entity.dart';

abstract class StoreRepository {
  Future<Either<Failure, List<CategoryE>>> getAllCategories();
  Future<Either<Failure, List<ProductsE>>> getAllProducts();
  Future<Either<Failure, List<BrandsE>>> getAllBrands();
}
