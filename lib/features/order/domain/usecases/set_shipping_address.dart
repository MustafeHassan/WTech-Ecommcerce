// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wtech_ecommerce/features/order/domain/entities/shipping_address_entitiy.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/order_repository.dart';

class SetShippingAddressUsecase {
  final OrderRepository orderRepository;
  SetShippingAddressUsecase({
    required this.orderRepository,
  });

  Future<Either<Failure, ShippingAddressE>> call({
    required String contactName,
    required String email,
    required String phoneNumber,
    required String addressLine1,
    required String? addressLine2,
    required String country,
    required String city,
    required int zipCode,
    required bool isDefault,
  }) async {
    return orderRepository.setShippingAddress(
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
  }
}
