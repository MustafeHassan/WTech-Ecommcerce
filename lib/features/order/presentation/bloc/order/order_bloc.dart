// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wtech_ecommerce/features/order/domain/usecases/get_all_orders_usecase.dart';
import 'package:wtech_ecommerce/features/order/domain/usecases/place_order_usecase.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/order_entity.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final PlaceOrderUscecase placeOrderUscecase;
  final GetAllOrdersUsecase getOrders;
  final List<OrderE> orders = [];
  OrderBloc({
    required this.placeOrderUscecase,
    required this.getOrders,
  }) : super(OrderInitial()) {
    on<AllOrdersRequisted>((event, emit) async {
      emit(OrderLoadingState());
      var failureOrData = await getOrders();
      failureOrData.fold((failure) => mapFailureToState(failure, emit), (data) {
        for (var i = 0; i < data.length; i++) {
          orders.add(data[i]);
        }

        emit(
          OrdersReceivedState(orders: orders),
        );
      });
    });
    on<OrderPlaced>((event, emit) async {
      emit(OrderLoadingState());
      var failureOrData = await placeOrderUscecase(
        orderId: event.orderId,
        orderPlacedDate: event.orderPlacedDate,
        orderStatus: event.orderStatus,
        shippingAddress: event.shippingAddress,
        paymentCard: event.paymentCard,
        shippingMethod: event.shippingMethod,
        totalToPay: event.totalToPay,
      );
      failureOrData.fold(
        (failure) => mapFailureToState(failure, emit),
        (data) => emit(
          OrderPlaceSuccess(),
        ),
      );
    });
  }

  void mapFailureToState(Failure failure, Emitter<OrderState> emit) {
    if (failure is UnexpectedErrorFailure) {
      emit(OrderErrorState(error: failure.failureMessage));
    }
  }
}
