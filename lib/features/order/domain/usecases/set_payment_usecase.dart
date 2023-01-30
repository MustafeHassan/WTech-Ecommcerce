// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/credit_card_entity.dart';
import '../repositories/order_repository.dart';

class SetPaymentUsecase {
  final OrderRepository orderRepository;
  SetPaymentUsecase({
    required this.orderRepository,
  });

  Future<Either<Failure, CreditCardE>> call({
    required String cardHolder,
    required String cardNumber,
    required String cardExpireDate,
    required int cvc,
    bool? isDefault,
  }) async {
    return orderRepository.setPayment(
      cardHolder: cardHolder,
      cardNumber: cardNumber,
      cardExpireDate: cardExpireDate,
      cvc: cvc,
    );
  }
}
