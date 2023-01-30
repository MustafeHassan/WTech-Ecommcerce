import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/core/errors/exceptions.dart';

import 'package:wtech_ecommerce/core/errors/failure.dart';
import 'package:wtech_ecommerce/features/store/domain/entities/category_entity.dart';
import 'package:wtech_ecommerce/features/store/domain/entities/products_entity.dart';

import '../../domain/entities/brands_entity.dart';
import '../../domain/repositories/store_repository.dart';
import '../datasources/store_remote_data_source.dart';

class StoreRepositoryImp implements StoreRepository {
  StoreRemoteDataSource remoteDataSource;
  StoreRepositoryImp({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, List<BrandsE>>> getAllBrands() async {
    try {
      var data = await remoteDataSource.getAllBrands();
      return Right(data);
    } on NoDataFoundException {
      return Left(NoDataFoundFailure());
    } on UnexpectedErrorException {
      return Left(UnexpectedErrorFailure());
    }
  }

  @override
  Future<Either<Failure, List<CategoryE>>> getAllCategories() async {
    try {
      var data = await remoteDataSource.getAllCategories();
      return Right(data);
    } on NoDataFoundException {
      return Left(NoDataFoundFailure());
    } on UnexpectedErrorException {
      return Left(UnexpectedErrorFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductsE>>> getAllProducts() async {
    try {
      var data = await remoteDataSource.getAllProducts();
      return Right(data);
    } on NoDataFoundException {
      return Left(NoDataFoundFailure());
    } on UnexpectedErrorException {
      return Left(UnexpectedErrorFailure());
    }
  }
}
