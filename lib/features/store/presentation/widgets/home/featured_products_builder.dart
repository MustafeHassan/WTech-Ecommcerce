import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:wtech_ecommerce/core/routes/app_route.dart';

import '../../../../../../core/theme/animations_asset.dart';

import '../../bloc/products/products_bloc.dart';
import 'featured_products_section.dart';

class FeaturedProductsBuilder extends StatelessWidget {
  const FeaturedProductsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state is MiniLoadingProductsState) {
          return Lottie.asset(
            miniLoading,
            width: 95.w,
            height: 95.h,
          );
        } else if (state is AllProductsReceivedState) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Products',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  TextButton(
                    onPressed: () {
                      context.goNamed(
                        allProductsScreen,
                        extra: state.products,
                      );
                    },
                    child: const Text('See all »'),
                  ),
                ],
              ),
              DelayedDisplay(
                delay: const Duration(milliseconds: 600),
                slidingCurve: Curves.ease,
                child: FeaturedProductsSection(
                  products: state.products,
                ),
              ),
            ],
          );
        } else if (state is ProductsErrorState) {
          return Column(
            children: [
              Lottie.asset(
                notFound,
                width: 170.w,
              ),
              Text(
                'No Products Found Unfortunately',
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
