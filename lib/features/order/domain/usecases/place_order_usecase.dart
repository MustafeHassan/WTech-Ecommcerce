// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/features/order/domain/repositories/order_repository.dart';

import '../../../../core/errors/failure.dart';

class PlaceOrderUscecase {
  final OrderRepository orderRepository;
  PlaceOrderUscecase({
    required this.orderRepository,
  });
  Future<Either<Failure, Unit>> call({
    required String orderId,
    required DateTime orderPlacedDate,
    required Map<String, dynamic> orderStatus,
    required Map<String, dynamic> shippingAddress,
    required Map<String, dynamic> paymentCard,
    required String shippingMethod,
    required double totalToPay,
  }) async {
    return orderRepository.placeOrder(
      orderId: orderId,
      orderPlacedDate: orderPlacedDate,
      orderStatus: orderStatus,
      shippingAddress: shippingAddress,
      paymentCard: paymentCard,
      shippingMethod: shippingMethod,
      totalToPay: totalToPay,
    );
  }
}
