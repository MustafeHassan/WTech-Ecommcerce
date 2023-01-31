import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wtech_dashboard/core/routes/routes.dart';
import 'package:wtech_dashboard/core/theme/theme.dart';
import 'package:wtech_dashboard/features/authentication/presentation/cubit/authenticaation_cubit.dart';
import 'package:wtech_dashboard/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:wtech_dashboard/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initServices();
  runApp(
    const WTechDashboard(),
  );
}

class WTechDashboard extends StatelessWidget {
  const WTechDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticaationCubit>(
          create: (context) => di.sl<AuthenticaationCubit>(),
        ),
        BlocProvider<DashboardCubit>(
          create: (context) => di.sl<DashboardCubit>(),
        ),
      ],
      child: MaterialApp.router(
        scrollBehavior: MyCustomScrollBehavior(),
        debugShowCheckedModeBanner: false,
        theme: themeData,
        title: ' WTech Admin Panel',
        routeInformationParser: AppRouter.router.routeInformationParser,
        routeInformationProvider: AppRouter.router.routeInformationProvider,
        routerDelegate: AppRouter.router.routerDelegate,
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
