// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class MiniLoadingState extends CategoryState {}

class CategoryErrorState extends CategoryState {
  final String error;
  CategoryErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

class AllCategoriesReceivedState extends CategoryState {
  final List<CategoryE> categories;
  AllCategoriesReceivedState({
    required this.categories,
  });
  @override
  List<Object> get props => [categories];
}
