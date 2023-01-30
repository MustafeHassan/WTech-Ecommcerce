import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:wtech_ecommerce/features/store/presentation/bloc/products/products_bloc.dart';

import '../../../../core/functions/snackbars.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/drawer.dart';
import '../../../../core/widgets/drawer_icon.dart';
import '../../../../core/widgets/scaffold_body.dart';

import '../../../favorites/presentation/bloc/favorites_bloc.dart';
import '../widgets/icon_box.dart';

class ProductsCategoryScreen extends StatelessWidget {
  const ProductsCategoryScreen({
    super.key,
    required this.categoryName,
  });

  final String categoryName;

  static final ValueNotifier<int> _prodcutLoadingLimit = ValueNotifier(4);
  static bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        leading: const DrawerOpen(),
        title: Text(categoryName.toUpperCase()),
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: Icon(
              CupertinoIcons.clear,
              color: AppTheme.white,
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: BlocListener<FavoritesBloc, FavoritesState>(
        listener: (context, state) {
          if (state is FavoritesErrorState) {
            showSnackBar(
              context: context,
              iconData: Icons.error,
              title: state.error,
              statusColor: AppTheme.red,
            );
          } else {
            showSnackBar(
              context: context,
              iconData: Icons.info,
              title: 'Added to favorites successfully',
              statusColor: AppTheme.primaryColor,
            );
          }
        },
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is AllProductsReceivedState) {
              var productsOfCategory = state.products
                  .where((element) => element.category == categoryName)
                  .toList();
              return ScaffoldBody(
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      'Add a Signature\n To Your Life',
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'The latest products that you would love',
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.h),
                    Expanded(
                      child: ValueListenableBuilder<int>(
                        valueListenable: _prodcutLoadingLimit,
                        builder: (context, value, child) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 30,
                              childAspectRatio: 1 / 1,
                            ),
                            itemCount: value > productsOfCategory.length
                                ? productsOfCategory.length
                                : value,
                            itemBuilder: (context, index) {
                              return DelayedDisplay(
                                delay: const Duration(milliseconds: 90),
                                fadingDuration:
                                    const Duration(milliseconds: 350),
                                slidingBeginOffset: Offset.fromDirection(3.2),
                                slidingCurve: Curves.easeInOut,
                                child: InkWell(
                                  onTap: () {
                                    context.goNamed(
                                      productDetailScreen,
                                      params: {
                                        'id': productsOfCategory[index].id
                                      },
                                      extra: productsOfCategory,
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Stack(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  productsOfCategory[index]
                                                      .imageUrls
                                                      .first,
                                              width: 90.w,
                                              height: 90.h,
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: IconBox(
                                                onTap: () {
                                                  context
                                                      .read<FavoritesBloc>()
                                                      .add(
                                                        ProductAddedToFavorites(
                                                          id: productsOfCategory[
                                                                  index]
                                                              .id,
                                                          name:
                                                              productsOfCategory[
                                                                      index]
                                                                  .name,
                                                          category:
                                                              productsOfCategory[
                                                                      index]
                                                                  .category,
                                                          imageUrl:
                                                              productsOfCategory[
                                                                      index]
                                                                  .imageUrls
                                                                  .first,
                                                          price:
                                                              productsOfCategory[
                                                                      index]
                                                                  .price,
                                                        ),
                                                      );
                                                },
                                                scale: 0.44,
                                                iconPath: AppIcons.bookmark,
                                                boxColor: AppTheme.primaryColor
                                                    .withOpacity(0.1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        productsOfCategory[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      Text(
                                        '\$${productsOfCategory[index].price}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _prodcutLoadingLimit.value += 5;
                      },
                      child: Text(
                        'LOAD COLLECTION',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
