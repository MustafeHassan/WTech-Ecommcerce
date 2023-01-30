import 'package:equatable/equatable.dart';

class CategoryE extends Equatable {
  final String categoryId;
  final String categoryName;
  final String categoryImageUrl;
  final List<dynamic> productsOverview;
  const CategoryE({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImageUrl,
    required this.productsOverview,
  });

  @override
  List<Object?> get props =>
      [categoryId, categoryName, categoryImageUrl, productsOverview];
}
