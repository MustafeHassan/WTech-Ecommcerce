import 'package:wtech_ecommerce/features/favorites/domain/entities/favorite_entity.dart';

class FavoriteModel extends FavoriteE {
  const FavoriteModel({
    required super.id,
    required super.name,
    required super.category,
    required super.imageUrl,
    required super.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'category': category,
      'imageUrl': imageUrl,
      'price': price,
    };
  }

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'] as String,
      name: map['name'] as String,
      category: map['category'] as String,
      imageUrl: map['imageUrl'] as String,
      price: map['price'] as double,
    );
  }
}
