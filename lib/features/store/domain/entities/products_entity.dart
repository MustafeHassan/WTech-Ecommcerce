import 'package:equatable/equatable.dart';

class ProductsE extends Equatable {
  final String id;
  final String name;
  final String brand;
  final String category;
  final String typeDescription;
  final String description;
  final List<dynamic> imageUrls;
  final double price;
  final Map<String, dynamic> specification;
  final num averageRating;
  final int totalRating;
  final List<dynamic> allReviews;
  const ProductsE({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.typeDescription,
    required this.description,
    required this.imageUrls,
    required this.price,
    required this.specification,
    required this.averageRating,
    required this.totalRating,
    required this.allReviews,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        brand,
        category,
        typeDescription,
        description,
        imageUrls,
        price,
        specification,
        averageRating,
        totalRating,
        allReviews
      ];
}
