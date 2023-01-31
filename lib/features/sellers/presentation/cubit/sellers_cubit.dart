import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sellers_state.dart';

class SellersCubit extends Cubit<SellersState> {
  SellersCubit() : super(SellersInitial());
}
