// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/features/order/domain/entities/credit_card_entity.dart';
import 'package:wtech_ecommerce/features/order/domain/repositories/order_repository.dart';

import '../../../../core/errors/failure.dart';

class GetAllCreditCardsUsecase {
  final OrderRepository orderRepository;
  GetAllCreditCardsUsecase({
    required this.orderRepository,
  });
  Future<Either<Failure, List<CreditCardE>>> call() async {
    return orderRepository.getAllCreditCards();
  }
}
