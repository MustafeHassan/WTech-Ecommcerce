part of 'credit_cards_bloc.dart';

abstract class CreditCardsEvent extends Equatable {
  const CreditCardsEvent();

  @override
  List<Object> get props => [];
}

class AllCreditCardsRequested extends CreditCardsEvent {}

class PaymentMethodSet extends CreditCardsEvent {
  final String cardHolder;
  final String cardNumber;
  final String cardExpireDate;
  final int cvc;
  final bool? isDefault;
  const PaymentMethodSet({
    required this.cardHolder,
    required this.cardNumber,
    required this.cardExpireDate,
    required this.cvc,
    this.isDefault,
  });

  @override
  List<Object> get props => [
        cardHolder,
        cardNumber,
        cardExpireDate,
        cvc,
        isDefault ?? false,
      ];
}
