// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'credit_cards_bloc.dart';

abstract class CreditCardsState extends Equatable {
  const CreditCardsState();

  @override
  List<Object> get props => [];
}

class CreditCardsInitial extends CreditCardsState {}

class CreditCardsLoading extends CreditCardsState {}

class CreditCardsError extends CreditCardsState {
  final String error;
  const CreditCardsError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class AllCreditCardsReceivedState extends CreditCardsState {
  final CreditCardE card;
  const AllCreditCardsReceivedState({
    required this.card,
  });
  @override
  List<Object> get props => [card];
}
