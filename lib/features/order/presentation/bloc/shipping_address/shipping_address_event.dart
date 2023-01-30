part of 'shipping_address_bloc.dart';

abstract class ShippingAddressEvent extends Equatable {
  const ShippingAddressEvent();

  @override
  List<Object> get props => [];
}

class AllShippingAddressRequested extends ShippingAddressEvent {}

class ShippingAddressSet extends ShippingAddressEvent {
  final String contactName;
  final String email;
  final String phoneNumber;
  final String addressLine1;
  final String? addressLine2;
  final String country;
  final String city;
  final int zipCode;
  final bool isDefault;
  const ShippingAddressSet({
    required this.contactName,
    required this.email,
    required this.phoneNumber,
    required this.addressLine1,
    this.addressLine2,
    required this.country,
    required this.city,
    required this.zipCode,
    required this.isDefault,
  });
  @override
  List<Object> get props => [
        contactName,
        email,
        phoneNumber,
        addressLine1,
        addressLine2 ?? '',
        country,
        city,
        zipCode,
        isDefault,
      ];
}
