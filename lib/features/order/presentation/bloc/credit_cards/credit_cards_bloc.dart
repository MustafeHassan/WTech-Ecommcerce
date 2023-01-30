import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/credit_card_entity.dart';
import '../../../domain/usecases/get_all_credit_cards_usecase.dart';
import '../../../domain/usecases/set_payment_usecase.dart';

part 'credit_cards_event.dart';
part 'credit_cards_state.dart';

class CreditCardsBloc extends Bloc<CreditCardsEvent, CreditCardsState> {
  final GetAllCreditCardsUsecase creditCardsUsecase;
  final SetPaymentUsecase paymentUsecase;

  List<CreditCardE> creditCards = [];
  CreditCardsBloc({
    required this.paymentUsecase,
    required this.creditCardsUsecase,
  }) : super(CreditCardsInitial()) {
    on<AllCreditCardsRequested>((event, emit) async {
      emit(CreditCardsLoading());
      var failureOrData = await creditCardsUsecase();
      failureOrData.fold((failure) => mapFailureToState(failure, emit), (data) {
        creditCards = data;

        emit(
          AllCreditCardsReceivedState(
            card: creditCards[creditCards.length - 1],
          ),
        );
      });
    });
    on<PaymentMethodSet>((event, emit) async {
      emit(CreditCardsLoading());
      var failureOrData = await paymentUsecase(
        cardHolder: event.cardHolder,
        cardNumber: event.cardNumber,
        cardExpireDate: event.cardExpireDate,
        cvc: event.cvc,
      );
      failureOrData.fold((failure) => mapFailureToState(failure, emit), (data) {
        creditCards.add(data);
        emit(AllCreditCardsReceivedState(card: data));
      });
    });
  }
  void mapFailureToState(Failure failure, Emitter<CreditCardsState> emit) {
    if (failure is UnexpectedErrorFailure) {
      emit(CreditCardsError(error: failure.failureMessage));
    }
  }
}
