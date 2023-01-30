import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/shipping_address_entitiy.dart';
import '../../../domain/usecases/get_all_shipping_address_usecase.dart';
import '../../../domain/usecases/set_shipping_address.dart';
import 'package:wtech_ecommerce/services_locator.dart' as di;
part 'shipping_address_event.dart';
part 'shipping_address_state.dart';

class ShippingAddressBloc
    extends Bloc<ShippingAddressEvent, ShippingAddressState> {
  final GetAllShippingAddressUsecase shippingAddressUsecase;
  final SetShippingAddressUsecase setShippingAddressUsecase;
  List<ShippingAddressE> shippingAddress = [];
  ShippingAddressBloc({
    required this.shippingAddressUsecase,
    required this.setShippingAddressUsecase,
  }) : super(ShippingAddressInitial()) {
    on<ShippingAddressSet>((event, emit) async {
      emit(ShippingAddressLoading());
      var failureOrData = await setShippingAddressUsecase.call(
        contactName: event.contactName,
        email: event.email,
        phoneNumber: event.phoneNumber,
        addressLine1: event.addressLine1,
        addressLine2: event.addressLine2,
        country: event.country,
        city: event.city,
        zipCode: event.zipCode,
        isDefault: event.isDefault,
      );
      failureOrData.fold((failure) => mapFailureToState(failure, emit), (data) {
        shippingAddress.add(data);
        emit(
          AllShippingAddressReceivedState(address: shippingAddress.last),
        );
      });
    });
    on<AllShippingAddressRequested>((event, emit) async {
      emit(ShippingAddressLoading());
      var failureOrData = await shippingAddressUsecase();
      failureOrData.fold((failure) => mapFailureToState(failure, emit),
          (data) async {
        if (data is List<ShippingAddressE>) {
          for (var i = 0; i < data.length; i++) {
            shippingAddress.add(data[i]);
          }
          emit(
            AllShippingAddressReceivedState(address: shippingAddress.last),
          );
        } else {
          emit(
            AllShippingAddressReceivedState(
              address: (data as ShippingAddressE),
            ),
          );
          var user = jsonDecode(di.preferences.getString('user')!)
              as Map<String, dynamic>;
          user.update(
            'address',
            (value) => {
              'address line 1': (data).addressLine1,
              'address line 2': (data).addressLine2,
              'country': (data).country,
              'city': (data).city,
              'zipCode': (data).zipCode,
            },
          );
          await di.preferences.setString('user', jsonEncode(user));
        }
      });
    });
  }

  void mapFailureToState(Failure failure, Emitter<ShippingAddressState> emit) {
    if (failure is UnexpectedErrorFailure) {
      emit(ShippingAddressErrorState(error: failure.failureMessage));
    }
  }
}
