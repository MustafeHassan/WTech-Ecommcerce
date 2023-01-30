// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:wtech_ecommerce/core/errors/failure.dart';
import 'package:wtech_ecommerce/features/store/domain/usecases/category_usecase.dart';

import '../../../domain/entities/category_entity.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategoriesUsecase allCategories;

  CategoryBloc({
    required this.allCategories,
  }) : super(CategoryInitial()) {
    on<AllCategoriesRequested>((event, emit) async {
      emit(MiniLoadingState());
      var failureOrData = await allCategories();
      failureOrData.fold(
        (failure) => mapFailureToState(failure, emit),
        (data) => emit(
          AllCategoriesReceivedState(categories: data),
        ),
      );
    });
  }
  void mapFailureToState(Failure failure, Emitter<CategoryState> emit) {
    if (failure is NoDataFoundFailure) {
      emit(CategoryErrorState(error: failure.failureMessage));
    } else if (failure is UnexpectedErrorFailure) {
      emit(CategoryErrorState(error: failure.failureMessage));
    }
  }
}
