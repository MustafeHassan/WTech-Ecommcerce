// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pages_cubit.dart';

abstract class PagesState extends Equatable {
  @override
  List<Object> get props => [];
}

class NewPageIndexState extends PagesState {
  final int pageIndex;
  NewPageIndexState({
    required this.pageIndex,
  });
  @override
  List<Object> get props => [pageIndex];
}
