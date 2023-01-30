import 'package:wtech_ecommerce/features/store/domain/entities/products_entity.dart';

class ProductsModel extends ProductsE {
  const ProductsModel({
    required super.id,
    required super.name,
    required super.brand,
    required super.category,
    required super.typeDescription,
    required super.description,
    required super.imageUrls,
    required super.price,
    required super.specification,
    required super.averageRating,
    required super.totalRating,
    required super.allReviews,
  });
  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      id: map['id'] as String,
      name: map['name'] as String,
      brand: map['brand'] as String,
      category: map['category'] as String,
      typeDescription: map['typeDescription'] as String,
      description: map['description'] as String,
      imageUrls: map['imageUrls'],
      price: (map['price'] as num).toDouble(),
      specification: Map<String, dynamic>.from(
        (map['specification'] == null
            ? map['specifications'] as Map<String, dynamic>
            : map['specification'] as Map<String, dynamic>),
      ),
      averageRating: map['averageRating'] as num,
      totalRating: map['totalRating'] as int,
      allReviews: map['allReviews'],
    );
  }
}
