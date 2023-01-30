import 'package:equatable/equatable.dart';

class OrderE extends Equatable {
  final String orderId;

  final DateTime orderPlacedDate;
  final Map<String, dynamic> orderStatus;
  final Map<String, dynamic> shippingAddress;
  final Map<String, dynamic> paymentCard;
  final String shippingMethod;
  final double totalToPay;
  const OrderE({
    required this.orderId,
    required this.orderPlacedDate,
    required this.orderStatus,
    required this.shippingAddress,
    required this.paymentCard,
    required this.shippingMethod,
    required this.totalToPay,
  });

  @override
  List<Object?> get props => [
        orderId,
        orderPlacedDate,
        orderStatus,
        shippingAddress,
        paymentCard,
        shippingMethod,
        totalToPay,
      ];
}
