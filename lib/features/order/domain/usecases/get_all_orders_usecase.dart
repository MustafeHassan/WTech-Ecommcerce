// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/features/order/domain/entities/order_entity.dart';
import 'package:wtech_ecommerce/features/order/domain/repositories/order_repository.dart';

import '../../../../core/errors/failure.dart';

class GetAllOrdersUsecase {
  final OrderRepository orderRepository;
  GetAllOrdersUsecase({
    required this.orderRepository,
  });
  Future<Either<Failure, List<OrderE>>> call() async {
    return orderRepository.getAllOrders();
  }
}
