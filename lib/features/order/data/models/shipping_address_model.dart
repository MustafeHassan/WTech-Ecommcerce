import 'package:wtech_ecommerce/features/order/domain/entities/shipping_address_entitiy.dart';

class ShippingAddressModel extends ShippingAddressE {
  const ShippingAddressModel({
    required super.contactName,
    required super.email,
    required super.phoneNumber,
    required super.addressLine1,
    required super.country,
    required super.city,
    required super.zipCode,
    required super.addressLine2,
    required super.isDefault,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'contactName': contactName,
      'email': email,
      'phoneNumber': phoneNumber,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'country': country,
      'city': city,
      'zipCode': zipCode,
      'isDefault': isDefault,
    };
  }

  factory ShippingAddressModel.fromMap(Map<String, dynamic> map) {
    return ShippingAddressModel(
      contactName: map['contactName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      addressLine1: map['addressLine1'] as String,
      addressLine2:
          map['addressLine2'] != null ? map['addressLine2'] as String : null,
      country: map['country'] as String,
      city: map['city'] as String,
      zipCode: map['zipCode'] as int,
      isDefault: map['isDefault'] as bool,
    );
  }
}
