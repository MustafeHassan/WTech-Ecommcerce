import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wtech_ecommerce/bloc_providers.dart';
import 'package:wtech_ecommerce/core/routes/router.dart';

import 'package:wtech_ecommerce/services_locator.dart' as di;

import 'core/theme/theme.dart';
import 'features/authentication/presentation/bloc/authentication_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await di.initServices();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(const WTechApp()),
    storage: storage,
  );
}

AuthenticationBloc? bloc;

class WTechApp extends StatelessWidget {
  const WTechApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return blocProviders(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'WTech Ecommerce',
            theme: AppTheme.themeData,
            routeInformationParser: AppRouter.router.routeInformationParser,
            routeInformationProvider: AppRouter.router.routeInformationProvider,
            routerDelegate: AppRouter.router.routerDelegate,
          );
        },
      ),
    );
  }
}
