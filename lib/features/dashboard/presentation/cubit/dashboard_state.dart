part of 'dashboard_cubit.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardDataLoading extends DashboardState {}

class DashboardDataError extends DashboardState {
  final String error;
  const DashboardDataError({
    required this.error,
  });
}

class DashboardDataRecieved extends DashboardState {
  final DashboardModel dashboard;
  const DashboardDataRecieved({
    required this.dashboard,
  });
  @override
  List<Object> get props => [dashboard];
}
