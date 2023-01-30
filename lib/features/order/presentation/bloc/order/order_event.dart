// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class AllOrdersRequisted extends OrderEvent {}

class OrderPlaced extends OrderEvent {
  final String orderId;

  final DateTime orderPlacedDate;
  final Map<String, dynamic> orderStatus;
  final Map<String, dynamic> shippingAddress;
  final Map<String, dynamic> paymentCard;
  final String shippingMethod;
  final double totalToPay;
  const OrderPlaced({
    required this.orderId,
    required this.orderPlacedDate,
    required this.orderStatus,
    required this.shippingAddress,
    required this.paymentCard,
    required this.shippingMethod,
    required this.totalToPay,
  });

  @override
  List<Object> get props => [
        orderId,
        orderPlacedDate,
        orderStatus,
        shippingAddress,
        paymentCard,
        shippingMethod,
        totalToPay
      ];
}
