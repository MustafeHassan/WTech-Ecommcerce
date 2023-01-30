import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wtech_ecommerce/core/routes/app_route.dart';

import '../../../../../core/theme/theme.dart';
import '../../../../../core/widgets/drawer.dart';
import '../../../../../core/widgets/drawer_icon.dart';
import '../../../../../core/widgets/scaffold_body.dart';
import '../../bloc/pages/pages_cubit.dart';
import '../../bloc/products/products_bloc.dart';
import '../../widgets/home/brands_builder.dart';
import '../../widgets/home/categories_builder.dart';
import '../../widgets/home/featured_products_builder.dart';
import '../../widgets/home/top_deals_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        leading: const DrawerOpen(),
        title: const Text(
          'STORE',
        ),
        actions: [
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Text(
                'New Tech Collection',
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                'Find the perfect product for your need',
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(height: 25.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<PagesCubit>().changePageIndex(1);
                    },
                    child: const Text('See all »'),
                  ),
                ],
              ),
              const CategoriesBuilder(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top deals',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('See all »'),
                  ),
                ],
              ),
              const TopDealsBuilder(),
              const FeaturedProductsBuilder(),
              const BrandsBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
