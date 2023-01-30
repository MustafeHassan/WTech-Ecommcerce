// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/core/errors/exceptions.dart';

import 'package:wtech_ecommerce/core/errors/failure.dart';
import 'package:wtech_ecommerce/features/order/data/datasources/order_remote_data_source.dart';
import 'package:wtech_ecommerce/features/order/domain/entities/credit_card_entity.dart';
import 'package:wtech_ecommerce/features/order/domain/entities/order_entity.dart';
import 'package:wtech_ecommerce/features/order/domain/entities/shipping_address_entitiy.dart';
import 'package:wtech_ecommerce/features/order/domain/repositories/order_repository.dart';

class OrderRepositoryImp implements OrderRepository {
  final OrderRemoteDataSource orderRemoteDataSource;
  OrderRepositoryImp({
    required this.orderRemoteDataSource,
  });
  @override
  Future<Either<Failure, Unit>> placeOrder(
      {required String orderId,
      required DateTime orderPlacedDate,
      required Map<String, dynamic> orderStatus,
      required Map<String, dynamic> shippingAddress,
      required Map<String, dynamic> paymentCard,
      required String shippingMethod,
      required double totalToPay}) async {
    try {
      await orderRemoteDataSource.placeOrder(
        orderId: orderId,
        orderPlacedDate: orderPlacedDate,
        orderStatus: orderStatus,
        shippingAddress: shippingAddress,
        paymentCard: paymentCard,
        shippingMethod: shippingMethod,
        totalToPay: totalToPay,
      );
      return const Right(unit);
    } on UnexpectedErrorException {
      return Left(UnexpectedErrorFailure());
    }
  }

  @override
  Future<Either<Failure, CreditCardE>> setPayment(
      {required String cardHolder,
      required String cardNumber,
      required String cardExpireDate,
      required int cvc,
      bool? isDefault}) async {
    try {
      var data = await orderRemoteDataSource.setPayment(
        cardHolder: cardHolder,
        cardNumber: cardNumber,
        cardExpireDate: cardExpireDate,
        cvc: cvc,
      );
      return Right(data);
    } on UnexpectedErrorException {
      return Left(UnexpectedErrorFailure());
    }
  }

  @override
  Future<Either<Failure, ShippingAddressE>> setShippingAddress(
      {required String contactName,
      required String email,
      required String phoneNumber,
      required String addressLine1,
      required String? addressLine2,
      required String country,
      required String city,
      required int zipCode,
      required bool isDefault}) async {
    try {
      var data = await orderRemoteDataSource.setShippingAddress(
        contactName: contactName,
        email: email,
        phoneNumber: phoneNumber,
        addressLine1: addressLine1,
        addressLine2: addressLine2,
        country: country,
        city: city,
        zipCode: zipCode,
        isDefault: isDefault,
      );
      return Right(data);
    } on UnexpectedErrorException {
      return Left(UnexpectedErrorFailure());
    }
  }

  @override
  Future<Either<Failure, List<CreditCardE>>> getAllCreditCards() async {
    try {
      var data = await orderRemoteDataSource.getAllCreditCards();
      return Right(data);
    } on UnexpectedErrorException {
      return Left(UnexpectedErrorFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> getAllShippingAddress() async {
    try {
      var data = await orderRemoteDataSource.getAllShippingAddress();
      return Right(data);
    } on UnexpectedErrorException {
      return Left(UnexpectedErrorFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderE>>> getAllOrders() async {
    try {
      var data = await orderRemoteDataSource.getAllOrders();
      return Right(data);
    } on UnexpectedErrorException {
      return Left(UnexpectedErrorFailure());
    }
  }
}
