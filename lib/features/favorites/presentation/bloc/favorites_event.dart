// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class FavoriteProductesRequested extends FavoritesEvent {
  @override
  List<Object> get props => [];
}

class ProductAddedToFavorites extends FavoritesEvent {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  const ProductAddedToFavorites({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
  });
  @override
  List<Object> get props => [id, name, category, imageUrl, price];
}

class ProductRemovedFromFavorites extends FavoritesEvent {
  final String id;

  const ProductRemovedFromFavorites({
    required this.id,
  });
  @override
  List<Object> get props => [id];
}
