import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wtech_ecommerce/core/errors/exceptions.dart';

import '../models/brands_model.dart';
import '../models/category_model.dart';
import '../models/prodcuts_model.dart';

abstract class StoreRemoteDataSource {
  Future<List<BrandsModel>> getAllBrands();
  Future<List<CategoryModel>> getAllCategories();

  Future<List<ProductsModel>> getAllProducts();
}

class StoreRemoteDataSourceImp implements StoreRemoteDataSource {
  FirebaseFirestore firestore;
  StoreRemoteDataSourceImp({
    required this.firestore,
  });
  @override
  Future<List<BrandsModel>> getAllBrands() async {
    List<BrandsModel> brands = [];
    var queryDocument = await firestore.collection('brands').get();
    if (queryDocument.docs.isEmpty) {
      throw NoDataFoundException();
    } else {
      for (var i = 0; i < queryDocument.docs.length; i++) {
        brands.add(
          BrandsModel.fromMap(
            queryDocument.docs[i].data(),
          ),
        );
      }
      return brands;
    }
  }

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    List<CategoryModel> categories = [];
    var categoryQueryDocument = await firestore.collection('categories').get();
    if (categoryQueryDocument.docs.isEmpty) {
      throw NoDataFoundException();
    } else {
      for (var i = 0; i < categoryQueryDocument.docs.length; i++) {
        categories.add(
          CategoryModel.fromMap(
            categoryQueryDocument.docs[i].data(),
          ),
        );
      }
      return categories;
    }
  }

  @override
  Future<List<ProductsModel>> getAllProducts() async {
    List<ProductsModel> products = [];
    var queryDocument = await firestore.collection('products').get();
    if (queryDocument.docs.isEmpty) {
      throw NoDataFoundException();
    } else {
      for (var i = 0; i < queryDocument.docs.length; i++) {
        products.add(
          ProductsModel.fromMap(
            queryDocument.docs[i].data(),
          ),
        );
      }
      return products;
    }
  }
}
