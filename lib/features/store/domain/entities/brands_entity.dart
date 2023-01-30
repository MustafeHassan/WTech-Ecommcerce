import 'package:equatable/equatable.dart';

class BrandsE extends Equatable {
  final String brandId;
  final String brandName;
  final String brandImageUrl;
  const BrandsE({
    required this.brandId,
    required this.brandName,
    required this.brandImageUrl,
  });

  @override
  List<Object?> get props => [brandId, brandName, brandImageUrl];
}
