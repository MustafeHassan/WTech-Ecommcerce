// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:wtech_ecommerce/features/store/domain/usecases/products_usecase.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/products_entity.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetAllProductsUsecase allProducts;
  ProductsBloc({
    required this.allProducts,
  }) : super(ProductsInitial()) {
    on<AllProductsRequested>((event, emit) async {
      emit(MiniLoadingProductsState());
      var failureOrData = await allProducts();
      failureOrData.fold((failure) => mapFailureToState(failure, emit), (data) {
        emit(
          AllProductsReceivedState(products: data),
        );
      });
    });
  }
  void mapFailureToState(Failure failure, Emitter<ProductsState> emit) {
    if (failure is NoDataFoundFailure) {
      emit(ProductsErrorState(error: failure.failureMessage));
    } else if (failure is UnexpectedErrorFailure) {
      emit(ProductsErrorState(error: failure.failureMessage));
    }
  }
}
