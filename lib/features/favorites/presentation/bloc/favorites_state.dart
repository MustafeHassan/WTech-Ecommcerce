// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesLoading extends FavoritesState {}

class FavoritesErrorState extends FavoritesState {
  final String error;
  const FavoritesErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

class FavoritesLoaded extends FavoritesState {
  final List<FavoriteE> favorites;
  const FavoritesLoaded({
    required this.favorites,
  });
  @override
  List<Object> get props => [favorites];
}
