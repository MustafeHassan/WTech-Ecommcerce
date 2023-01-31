import 'package:dartz/dartz.dart';
import 'package:wtech_dashboard/core/errors/exceptions.dart';
import 'package:wtech_dashboard/core/errors/failure.dart';
import 'package:wtech_dashboard/core/network/network_info.dart';
import 'package:wtech_dashboard/features/dashboard/data/datasources/dashboard_datasource.dart';
import 'package:wtech_dashboard/features/dashboard/data/models/dashboard_model.dart';

class DashboardRepository {
  DashboardDataSource dashboardDataSource;
  NetworkInfo networkInfo;
  DashboardRepository({
    required this.dashboardDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, DashboardModel>> getDashboardDataRepo() async {
    try {
      var data = await dashboardDataSource.getDashboardData();
      return Right(data);
    } on UnexpectedErrorException {
      return Left(UnexpectedErrorFailure());
    }
  }
}
