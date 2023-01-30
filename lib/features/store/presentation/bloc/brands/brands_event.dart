part of 'brands_bloc.dart';

abstract class BrandsEvent extends Equatable {
  const BrandsEvent();

  @override
  List<Object> get props => [];
}

class AllBrandsRequested extends BrandsEvent {
  @override
  List<Object> get props => [];
}
