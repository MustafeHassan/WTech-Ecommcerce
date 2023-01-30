// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'brands_bloc.dart';

abstract class BrandsState extends Equatable {
  const BrandsState();

  @override
  List<Object> get props => [];
}

class BrandsInitial extends BrandsState {}

class MiniLoadingBrandsState extends BrandsState {}

class BrandsErrorState extends BrandsState {
  final String error;
  const BrandsErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class AllBrandsReceivedState extends BrandsState {
  final List<BrandsE> brands;
  const AllBrandsReceivedState({
    required this.brands,
  });

  @override
  List<Object> get props => [brands];
}
