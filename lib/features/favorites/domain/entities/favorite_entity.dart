// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FavoriteE extends Equatable {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  const FavoriteE({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
  });

  @override
  List<Object?> get props => [id, name, category, imageUrl, price];
}
