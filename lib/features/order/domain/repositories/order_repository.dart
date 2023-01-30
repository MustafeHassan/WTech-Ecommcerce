import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/features/order/domain/entities/shipping_address_entitiy.dart';

import '../../../../core/errors/failure.dart';
import '../entities/credit_card_entity.dart';
import '../entities/order_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure, Unit>> placeOrder({
    required String orderId,
    required DateTime orderPlacedDate,
    required Map<String, dynamic> orderStatus,
    required Map<String, dynamic> shippingAddress,
    required Map<String, dynamic> paymentCard,
    required String shippingMethod,
    required double totalToPay,
  });

  Future<Either<Failure, CreditCardE>> setPayment({
    required String cardHolder,
    required String cardNumber,
    required String cardExpireDate,
    required int cvc,
    bool? isDefault,
  });

  Future<Either<Failure, ShippingAddressE>> setShippingAddress({
    required String contactName,
    required String email,
    required String phoneNumber,
    required String addressLine1,
    required String? addressLine2,
    required String country,
    required String city,
    required int zipCode,
    required bool isDefault,
  });

  Future<Either<Failure, List<CreditCardE>>> getAllCreditCards();
  Future<Either<Failure, dynamic>> getAllShippingAddress();
  Future<Either<Failure, List<OrderE>>> getAllOrders();
}
