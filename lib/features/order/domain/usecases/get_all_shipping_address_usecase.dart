// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/features/order/domain/repositories/order_repository.dart';

import '../../../../core/errors/failure.dart';

class GetAllShippingAddressUsecase {
  final OrderRepository orderRepository;
  GetAllShippingAddressUsecase({
    required this.orderRepository,
  });
  Future<Either<Failure, dynamic>> call() async {
    return orderRepository.getAllShippingAddress();
  }
}
