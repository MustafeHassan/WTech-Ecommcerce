import 'package:wtech_ecommerce/features/order/domain/entities/order_entity.dart';

class OrderModel extends OrderE {
  const OrderModel({
    required super.orderId,
    required super.orderPlacedDate,
    required super.orderStatus,
    required super.shippingAddress,
    required super.paymentCard,
    required super.shippingMethod,
    required super.totalToPay,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'orderPlacedDate': orderPlacedDate.millisecondsSinceEpoch,
      'orderStatus': orderStatus,
      'shippingAddress': shippingAddress,
      'paymentCard': paymentCard,
      'shippingMethod': shippingMethod,
      'totalToPay': totalToPay,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] as String,
      orderPlacedDate:
          DateTime.fromMillisecondsSinceEpoch(map['orderPlacedDate'] as int),
      orderStatus: Map<String, dynamic>.from(
          (map['orderStatus'] as Map<String, dynamic>)),
      shippingAddress: Map<String, dynamic>.from(
          (map['shippingAddress'] as Map<String, dynamic>)),
      paymentCard: Map<String, dynamic>.from(
          (map['paymentCard'] as Map<String, dynamic>)),
      shippingMethod: map['shippingMethod'] as String,
      totalToPay: map['totalToPay'] as double,
    );
  }
}
