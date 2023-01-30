// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class MiniLoadingProductsState extends ProductsState {}

class ProductsErrorState extends ProductsState {
  final String error;
  const ProductsErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

class AllProductsReceivedState extends ProductsState {
  final List<ProductsE> products;
  const AllProductsReceivedState({
    required this.products,
  });
  @override
  List<Object> get props => [products];
}
