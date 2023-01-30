// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class ProductAddedToCart extends CartEvent {
  final CartItem item;
  const ProductAddedToCart({required this.item});
}

class QuantityIncreased extends CartEvent {
  final CartItem item;
  final int? index;
  const QuantityIncreased({
    required this.item,
    this.index,
  });
  @override
  List<Object> get props => [item, index!];
}

class QuantityDecreased extends CartEvent {
  final CartItem item;
  final int? index;
  const QuantityDecreased({
    required this.item,
    this.index,
  });
  @override
  List<Object> get props => [item, index!];
}

class ProductOfCartRemoved extends CartEvent {
  final CartItem item;

  const ProductOfCartRemoved({
    required this.item,
  });
  @override
  List<Object> get props => [item];
}
