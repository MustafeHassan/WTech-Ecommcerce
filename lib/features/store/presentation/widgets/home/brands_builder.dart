import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:wtech_ecommerce/core/routes/app_route.dart';
import 'package:wtech_ecommerce/features/store/presentation/bloc/products/products_bloc.dart';

import '../../../../../../core/theme/animations_asset.dart';
import '../../bloc/brands/brands_bloc.dart';
import 'brands_section.dart';

class BrandsBuilder extends StatelessWidget {
  const BrandsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var productState = BlocProvider.of<ProductsBloc>(context).state;
    return BlocBuilder<BrandsBloc, BrandsState>(
      builder: (context, state) {
        if (state is MiniLoadingBrandsState) {
          return Lottie.asset(
            miniLoading,
            width: 95.w,
            height: 95.h,
          );
        } else if (state is AllBrandsReceivedState) {
          var productState = BlocProvider.of<ProductsBloc>(context).state
                  is AllProductsReceivedState
              ? BlocProvider.of<ProductsBloc>(context).state
                  as AllProductsReceivedState
              : null;

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Search by brand',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  TextButton(
                    onPressed: () {
                      context.goNamed(
                        allBrandsScreen,
                        extra: [state.brands, productState?.products],
                      );
                    },
                    child: const Text('See all »'),
                  ),
                ],
              ),
              DelayedDisplay(
                delay: const Duration(milliseconds: 800),
                slidingCurve: Curves.ease,
                child: BrandsSection(
                  products: productState?.products,
                  brands: state.brands,
                ),
              ),
            ],
          );
        } else if (state is BrandsErrorState) {
          return Column(
            children: [
              Lottie.asset(
                notFound,
                width: 170.w,
              ),
              Text(
                'No Brands Found Unfortunately',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
