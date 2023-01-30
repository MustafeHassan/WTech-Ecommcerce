import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:wtech_ecommerce/features/cart/domain/entities/cart_entity.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> with HydratedMixin {
  CartBloc() : super(const CartState()) {
    on<ProductAddedToCart>((event, emit) async {
      emit(
        CartState(
          cartItems: List<CartItem>.from(state.cartItems)
            ..add(
              event.item,
            ),
        ),
      );
    });
    on<QuantityDecreased>((event, emit) async {
      state.cartItems.removeAt(
        event.index!,
      );
      emit(
        CartState(
          cartItems: List<CartItem>.from(state.cartItems)
            ..insert(event.index!, event.item),
        ),
      );
    });

    on<QuantityIncreased>((event, emit) async {
      state.cartItems.removeAt(
        event.index!,
      );
      emit(
        CartState(
          cartItems: List<CartItem>.from(state.cartItems)
            ..insert(event.index!, event.item),
        ),
      );
    });
    on<ProductOfCartRemoved>((event, emit) async {
      emit(
        CartState(
          cartItems: List<CartItem>.from(state.cartItems)
            ..remove(
              event.item,
            ),
        ),
      );
    });
  }

  @override
  CartState? fromJson(Map<String, dynamic> json) {
    return CartState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(CartState state) {
    return state.toMap();
  }
}
