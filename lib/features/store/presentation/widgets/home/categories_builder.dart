import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lottie/lottie.dart';

import '../../../../../../core/theme/animations_asset.dart';
import '../../bloc/category/category_bloc.dart';
import 'category_section.dart';

class CategoriesBuilder extends StatelessWidget {
  const CategoriesBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is MiniLoadingState) {
          return Lottie.asset(
            miniLoading,
            repeat: true,
            width: 95.w,
            height: 95.h,
          );
        }
        if (state is AllCategoriesReceivedState) {
          return DelayedDisplay(
            delay: const Duration(milliseconds: 200),
            slidingCurve: Curves.ease,
            child: CategoriesSection(
              categories: state.categories,
            ),
          );
        }
        if (state is CategoryErrorState) {
          return Column(
            children: [
              Lottie.asset(
                notFound,
                width: 170.w,
              ),
              Text(
                'No Categories Found Unfortunately',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          );
        }
        return const Text('No Categories Found');
      },
    );
  }
}
