import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wtech_ecommerce/features/favorites/presentation/pages/favorites_page.dart';
import 'package:wtech_ecommerce/features/settings/presentation/screens/settings_screen.dart';
import 'package:wtech_ecommerce/features/store/presentation/bloc/brands/brands_bloc.dart';
import 'package:wtech_ecommerce/features/store/presentation/bloc/products/products_bloc.dart';
import 'package:wtech_ecommerce/features/store/presentation/screens/pages/categorey_page.dart';

import 'package:wtech_ecommerce/core/theme/theme.dart';
import 'package:wtech_ecommerce/features/store/presentation/bloc/pages/pages_cubit.dart';

import '../../../../core/functions/exit_app_alert.dart';

import '../../../favorites/presentation/bloc/favorites_bloc.dart';
import '../bloc/category/category_bloc.dart';
import '../widgets/home/bottom_nav_bar.dart';
import 'pages/home_page.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final List<Widget> pages = [
    HomePage(),
    CategoreyPage(),
    FavoritesPage(),
    Container(
      child: Center(
        child: Text(
          'Settings Page',
        ),
      ),
    ),
  ];
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ProductsBloc>(context).add(AllProductsRequested());
    BlocProvider.of<CategoryBloc>(context).add(AllCategoriesRequested());
    BlocProvider.of<BrandsBloc>(context).add(AllBrandsRequested());
    BlocProvider.of<FavoritesBloc>(context).add(FavoriteProductesRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PagesCubit(),
      child: WillPopScope(
        onWillPop: () => appExitAlert(context),
        child: Builder(
          builder: (context) {
            return BlocBuilder<PagesCubit, PagesState>(
              builder: (context, state) {
                if (state is NewPageIndexState) {
                  return Scaffold(
                    backgroundColor: AppTheme.white,
                    bottomNavigationBar:
                        BottomNavBar(pageIndex: state.pageIndex),
                    body: IndexedStack(
                      index: state.pageIndex,
                      children: const [
                        HomePage(),
                        CategoreyPage(),
                        FavoritesPage(),
                        SettingsPage(),
                      ],
                    ),
                    // body: pages[state.pageIndex],
                  );
                } else {
                  return const SizedBox();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
