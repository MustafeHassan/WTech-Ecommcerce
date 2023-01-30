// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pages_state.dart';

class PagesCubit extends Cubit<PagesState> {
  PagesCubit() : super(NewPageIndexState(pageIndex: 0));

  void changePageIndex(int index) {
    emit(NewPageIndexState(pageIndex: index));
  }
}
