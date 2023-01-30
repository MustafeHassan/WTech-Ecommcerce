// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'shipping_address_bloc.dart';

abstract class ShippingAddressState extends Equatable {
  const ShippingAddressState();

  @override
  List<Object> get props => [];
}

class ShippingAddressInitial extends ShippingAddressState {}

class ShippingAddressLoading extends ShippingAddressState {}

class ShippingAddressErrorState extends ShippingAddressState {
  final String error;
  const ShippingAddressErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class AllShippingAddressReceivedState extends ShippingAddressState {
  final dynamic address;
  const AllShippingAddressReceivedState({
    required this.address,
  });
  @override
  List<Object> get props => [address];
}
