import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wtech_dashboard/core/errors/failure.dart';

import 'package:wtech_dashboard/features/dashboard/data/models/dashboard_model.dart';
import 'package:wtech_dashboard/features/dashboard/data/repositories/dashboard_repository.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardRepository dashboardRepository;
  DashboardCubit(
    this.dashboardRepository,
  ) : super(DashboardDataLoading());

  Future<void> getDashboardDataCubit() async {
    var response = await dashboardRepository.getDashboardDataRepo();
    response.fold(
      (l) {
        if (l is OfflineFailure) {
          emit(DashboardDataError(error: l.failureMessage));
        }
        if (l is UnexpectedErrorFailure) {
          emit(DashboardDataError(error: l.failureMessage));
        }
      },
      (r) => emit(
        DashboardDataRecieved(dashboard: r),
      ),
    );
  }
}
