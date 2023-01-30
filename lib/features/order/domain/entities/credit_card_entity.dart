import 'package:equatable/equatable.dart';

class CreditCardE extends Equatable {
  final String cardHolder;
  final String cardNumber;
  final String cardExpireDate;
  final int cvc;
  final bool? isDefault;
  const CreditCardE({
    required this.cardHolder,
    required this.cardNumber,
    required this.cardExpireDate,
    required this.cvc,
    this.isDefault,
  });

  @override
  List<Object?> get props => [
        cardHolder,
        cardNumber,
        cardExpireDate,
        cvc,
        isDefault,
      ];
}
