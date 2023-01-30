// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ShippingAddressE extends Equatable {
  final String contactName;
  final String email;
  final String phoneNumber;
  final String addressLine1;
  final String? addressLine2;
  final String country;
  final String city;
  final int zipCode;
  final bool isDefault;
  const ShippingAddressE({
    required this.contactName,
    required this.email,
    required this.phoneNumber,
    required this.addressLine1,
    this.addressLine2,
    required this.country,
    required this.city,
    required this.zipCode,
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [
        contactName,
        email,
        phoneNumber,
        addressLine1,
        addressLine2,
        country,
        city,
        zipCode,
        isDefault,
      ];
}
