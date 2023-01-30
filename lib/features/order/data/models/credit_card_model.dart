import 'package:wtech_ecommerce/features/order/domain/entities/credit_card_entity.dart';

class CreditCardModel extends CreditCardE {
  const CreditCardModel({
    required super.cardHolder,
    required super.cardNumber,
    required super.cardExpireDate,
    required super.cvc,
    required super.isDefault,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cardHolder': cardHolder,
      'cardNumber': cardNumber,
      'cardExpireDate': cardExpireDate,
      'cvc': cvc,
      'isDefault': isDefault,
    };
  }

  factory CreditCardModel.fromMap(Map<String, dynamic> map) {
    return CreditCardModel(
      cardHolder: map['cardHolder'] as String,
      cardNumber: map['cardNumber'] as String,
      cardExpireDate: map['cardExpireDate'] as String,
      cvc: map['cvc'] as int,
      isDefault: map['isDefault'] != null ? map['isDefault'] as bool : null,
    );
  }
}
