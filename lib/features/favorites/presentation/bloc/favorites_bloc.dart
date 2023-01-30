import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wtech_ecommerce/features/favorites/domain/entities/favorite_entity.dart';
import 'package:wtech_ecommerce/features/favorites/domain/usecases/add_product_to_favorites_usecase.dart';
import 'package:wtech_ecommerce/features/favorites/domain/usecases/get_all_favorites_products_usecase.dart';
import 'package:wtech_ecommerce/features/favorites/domain/usecases/remove_product_from_favorite_usecase.dart';

import '../../../../core/errors/failure.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetAllFavoriteProductsUsecase getFavorites;
  final AddProductToFavoritesUsecase addToFavorites;
  final RemoveProductFromFavoritesUsecase removeFromFavorites;
  final List<FavoriteE> favorites = [];
  FavoritesBloc({
    required this.getFavorites,
    required this.addToFavorites,
    required this.removeFromFavorites,
  }) : super(FavoritesLoading()) {
    on<FavoriteProductesRequested>((event, emit) async {
      var failureOrData = await getFavorites();
      failureOrData.fold((failure) => mapFailureToState(failure, emit), (data) {
        favorites.addAll(favorites);
        emit(
          FavoritesLoaded(favorites: favorites),
        );
      });
    });
    on<ProductAddedToFavorites>((event, emit) async {
      emit(FavoritesLoading());
      var failureOrData = await addToFavorites(
        id: event.id,
        name: event.name,
        category: event.category,
        imageUrl: event.imageUrl,
        price: event.price,
      );
      failureOrData.fold(
        (failure) => mapFailureToState(failure, emit),
        (data) {
          favorites.add(data);
          emit(
            FavoritesLoaded(
              favorites: favorites,
            ),
          );
        },
      );
    });
    on<ProductRemovedFromFavorites>((event, emit) async {
      emit(FavoritesLoading());
      var failureOrData = await removeFromFavorites(
        id: event.id,
      );
      failureOrData.fold((failure) => mapFailureToState(failure, emit), (data) {
        favorites.removeWhere((element) => element.id == event.id);
        emit(
          FavoritesLoaded(favorites: favorites),
        );
      });
    });
  }

  void mapFailureToState(Failure failure, Emitter<FavoritesState> emit) {
    if (failure is ProductAlreadyExistFailure) {
      emit(FavoritesErrorState(error: failure.failureMessage));
    } else if (failure is UnexpectedErrorFailure) {
      emit(FavoritesErrorState(error: failure.failureMessage));
    }
  }
}
