import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  CustomersCubit() : super(CustomersInitial());
}
