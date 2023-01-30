import 'package:wtech_ecommerce/features/store/domain/entities/category_entity.dart';

class CategoryModel extends CategoryE {
  const CategoryModel({
    required super.categoryId,
    required super.categoryName,
    required super.categoryImageUrl,
    required super.productsOverview,
  });
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['categoreyId'].toString(),
      categoryName: map['categoreyName'] as String,
      categoryImageUrl: map['categoreyImageUrl'] as String,
      productsOverview: map['productsOverview'] as List<dynamic>,
    );
  }

  @override
  bool get stringify => true;
}
