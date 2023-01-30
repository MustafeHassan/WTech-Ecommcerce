// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderPlaceSuccess extends OrderState {}

class OrdersReceivedState extends OrderState {
  final List<OrderE> orders;
  const OrdersReceivedState({
    required this.orders,
  });
  @override
  List<Object> get props => [orders];
}

class OrderErrorState extends OrderState {
  final String error;
  const OrderErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}
