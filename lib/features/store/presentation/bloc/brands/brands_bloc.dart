// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:wtech_ecommerce/features/store/domain/entities/brands_entity.dart';
import 'package:wtech_ecommerce/features/store/domain/usecases/brands_usecase.dart';

import '../../../../../core/errors/failure.dart';

part 'brands_event.dart';
part 'brands_state.dart';

class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
  final GetAllBrandsUsecase allBrands;
  BrandsBloc({
    required this.allBrands,
  }) : super(BrandsInitial()) {
    on<AllBrandsRequested>((event, emit) async {
      emit(MiniLoadingBrandsState());
      var failureOrData = await allBrands();
      failureOrData.fold(
        (failure) => mapFailureToState(failure, emit),
        (data) => emit(
          AllBrandsReceivedState(brands: data),
        ),
      );
    });
  }
  void mapFailureToState(Failure failure, Emitter<BrandsState> emit) {
    if (failure is NoDataFoundFailure) {
      emit(BrandsErrorState(error: failure.failureMessage));
    } else if (failure is UnexpectedErrorFailure) {
      emit(BrandsErrorState(error: failure.failureMessage));
    }
  }
}
