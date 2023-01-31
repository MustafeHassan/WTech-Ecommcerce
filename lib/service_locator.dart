import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:wtech_dashboard/features/authentication/data/datasources/auth_data_source.dart';
import 'package:wtech_dashboard/features/authentication/data/repositories/auth_repo_imp.dart';
import 'package:wtech_dashboard/features/authentication/domain/repositories/auth_rep.dart';
import 'package:wtech_dashboard/features/authentication/domain/usecases/forgot_password.dart';
import 'package:wtech_dashboard/features/authentication/domain/usecases/login_usecase.dart';
import 'package:wtech_dashboard/features/authentication/presentation/cubit/authenticaation_cubit.dart';
import 'package:wtech_dashboard/features/dashboard/data/datasources/dashboard_datasource.dart';
import 'package:wtech_dashboard/features/dashboard/data/repositories/dashboard_repository.dart';
import 'package:wtech_dashboard/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'core/network/internet_connection_checker.dart';
import 'core/network/network_info.dart';
import 'firebase_options.dart';

GetIt sl = GetIt.instance;
late SharedPreferences preferences;
Future<void> initServices() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  preferences = await SharedPreferences.getInstance();

  //! Features

  //*  Bloc

  sl.registerFactory<AuthenticaationCubit>(
    () => AuthenticaationCubit(
      login: sl(),
      forgotPassword: sl(),
    ),
  );
  sl.registerFactory<DashboardCubit>(
    () => DashboardCubit(
      sl(),
    ),
  );

  //* Usecase

  sl.registerLazySingleton<LogInUsecase>(
    () => LogInUsecase(
      authRepo: sl(),
    ),
  );
  sl.registerLazySingleton<ForgotPasswordUsecase>(
    () => ForgotPasswordUsecase(
      authRepo: sl(),
    ),
  );

  //*  Repository

  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(
      authDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepository(
      dashboardDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  //* Netowrk Info
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(connectionChecker: sl()),
  );
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );

  //* Data Sources
  sl.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImp(
      auth: sl<FirebaseAuth>(),
      firestore: sl<FirebaseFirestore>(),
    ),
  );

  //* Data Sources
  sl.registerLazySingleton<DashboardDataSource>(
    () => DashboardDataSource(
      firestore: sl<FirebaseFirestore>(),
    ),
  );

  //!! External

  sl.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );

  sl.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
}
