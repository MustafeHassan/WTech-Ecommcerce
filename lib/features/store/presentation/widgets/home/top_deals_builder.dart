import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lottie/lottie.dart';
import 'package:wtech_ecommerce/features/store/presentation/widgets/home/top_deals_section.dart';

import '../../../../../../core/theme/animations_asset.dart';

import '../../bloc/products/products_bloc.dart';

class TopDealsBuilder extends StatelessWidget {
  const TopDealsBuilder({super.key});

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
          return DelayedDisplay(
            delay: const Duration(milliseconds: 400),
            slidingCurve: Curves.ease,
            child: TopDealsSection(
              topDeals: state.products,
            ),
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
