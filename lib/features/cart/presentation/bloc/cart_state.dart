// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartItem> cartItems;
  const CartState({this.cartItems = const <CartItem>[]});
  @override
  List<Object> get props => [cartItems];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'items': cartItems.map((item) => item.toMap()).toList(),
    };
  }

  factory CartState.fromMap(Map<String, dynamic> map) {
    return CartState(
      cartItems: List<CartItem>.from(
        (map['items'] as List<dynamic>).map<CartItem>(
          (item) => CartItem.fromMap(item as Map<String, dynamic>),
        ),
      ),
    );
  }
}
