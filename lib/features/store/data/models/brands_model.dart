import 'package:wtech_ecommerce/features/store/domain/entities/brands_entity.dart';

class BrandsModel extends BrandsE {
  const BrandsModel({
    required super.brandId,
    required super.brandName,
    required super.brandImageUrl,
  });

  factory BrandsModel.fromMap(Map<String, dynamic> map) {
    return BrandsModel(
      brandId: map['brandId'],
      brandName: map['brandName'],
      brandImageUrl: map['brandImageUrl'],
    );
  }
}
