import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:wtech_ecommerce/core/routes/app_route.dart';
import 'package:wtech_ecommerce/core/theme/animations_asset.dart';
import 'package:wtech_ecommerce/features/store/presentation/widgets/category/categories_overview.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../../core/widgets/drawer.dart';
import '../../../../../core/widgets/drawer_icon.dart';
import '../../../../../core/widgets/scaffold_body.dart';
import '../../bloc/category/category_bloc.dart';
import '../../bloc/products/products_bloc.dart';

class CategoreyPage extends StatelessWidget {
  const CategoreyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is AllCategoriesReceivedState) {
          return Scaffold(
            drawer: const DrawerWidget(),
            appBar: AppBar(
              leading: const DrawerOpen(),
              title: const Text(
                'CATEGORIES',
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    context.goNamed(
                      filteredAndSortScreen,
                      extra: state.categories,
                    );
                  },
                  child: SvgPicture.asset(AppIcons.filter),
                ),
                SizedBox(width: 10.w),
                BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    if (state is AllProductsReceivedState) {
                      return IconButton(
                        onPressed: () {
                          context.goNamed(
                            searchProductsScreen,
                            extra: state.products,
                          );
                        },
                        icon: Icon(
                          CupertinoIcons.search,
                          color: AppTheme.white,
                        ),
                      );
                    } else {
                      return IconButton(
                        onPressed: () {
                          context.goNamed(
                            searchProductsScreen,
                            extra: [],
                          );
                        },
                        icon: Icon(
                          CupertinoIcons.search,
                          color: AppTheme.white,
                        ),
                      );
                    }
                  },
                ),
                SizedBox(width: 15.w),
              ],
            ),
            body: ScaffoldBody(
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    'Main Collection\nClassic Collections',
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Search through more than 1000+ products',
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  Expanded(
                      child: CategoriesOverview(categories: state.categories)),
                ],
              ),
            ),
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(notFound),
              Text(
                'No Categories Found Unfortunately',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        );
      },
    );
  }
}
