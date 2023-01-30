// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wtech_ecommerce/core/errors/exceptions.dart';

import 'package:wtech_ecommerce/features/favorites/data/models/favorite_model.dart';

abstract class FavoriteRemoteDataSource {
  Future<List<FavoriteModel>> getAllFavoriteProducts();
  Future<FavoriteModel> addProductToFavorites({
    required String id,
    required String name,
    required String category,
    required String imageUrl,
    required double price,
  });
  Future<void> removeProductToFavorites({required String id});
}

class FavoriteRemoteDataSourceImp implements FavoriteRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  FavoriteRemoteDataSourceImp({
    required this.firestore,
    required this.auth,
  });
  @override
  Future<FavoriteModel> addProductToFavorites({
    required String id,
    required String name,
    required String category,
    required String imageUrl,
    required double price,
  }) async {
    final String uid = auth.currentUser!.uid;
    try {
      var product = await firestore
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .doc(id)
          .get();
      if (product.exists) {
        throw ProductAlreadyExistException();
      } else {
        await firestore
            .collection('users')
            .doc(uid)
            .collection('favorites')
            .doc(id)
            .set({
          "id": id,
          "name": name,
          "category": category,
          "price": price,
          "imageUrl": imageUrl,
        });
        return FavoriteModel.fromMap({
          "id": id,
          "name": name,
          "category": category,
          "price": price,
          "imageUrl": imageUrl,
        });
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<FavoriteModel>> getAllFavoriteProducts() async {
    final String uid = auth.currentUser!.uid;
    final List<FavoriteModel> favorites = [];
    var allProducts = await firestore
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .get();
    try {
      for (var i = 0; i < allProducts.docs.length; i++) {
        favorites.add(
          FavoriteModel.fromMap(
            allProducts.docs[i].data(),
          ),
        );
      }
      return favorites;
    } catch (_) {
      throw UnexpectedErrorException();
    }
  }

  @override
  Future<void> removeProductToFavorites({required String id}) async {
    final String uid = auth.currentUser!.uid;
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .doc(id)
          .delete();
    } catch (_) {
      throw UnexpectedErrorException();
    }
  }
}
