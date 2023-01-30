import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/functions/snackbars.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/theme/animations_asset.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/scaffold_body.dart';
import '../../../store/presentation/bloc/products/products_bloc.dart';
import '../../../store/presentation/widgets/icon_box.dart';
import '../bloc/favorites_bloc.dart';

class EmptyFavorites extends StatefulWidget {
  const EmptyFavorites({
    Key? key,
  }) : super(key: key);

  @override
  State<EmptyFavorites> createState() => _EmptyFavoritesState();
}

class _EmptyFavoritesState extends State<EmptyFavorites> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoritesBloc, FavoritesState>(
      listener: (context, state) {
        if (state is FavoritesErrorState) {
          showSnackBar(
            context: context,
            iconData: Icons.error,
            title: state.error,
            statusColor: AppTheme.red,
          );
        }
        if (state is FavoritesLoaded) {
          context.replaceNamed(favoritesScreen);
        }
      },
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, stateProducts) {
          if (stateProducts is AllProductsReceivedState) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    context.goNamed(
                      searchProductsScreen,
                      extra: stateProducts.products,
                    );
                  },
                  icon: Icon(
                    CupertinoIcons.search,
                    color: AppTheme.white,
                  ),
                ),
                title: const Text(
                  'FAVORITES',
                ),
              ),
              body: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 24.0.h, right: 24.h, top: 24.h),
                    child: Text(
                      'Seems like you don’t have any items \n in your favorite list.',
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: AppTheme.borderColor,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ScaffoldBody(
                      lessHight: true,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 30.h),
                            Text(
                              'Products you might like',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: GridView.builder(
                                primary: false,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 30,
                                  childAspectRatio: 1 / 1,
                                ),
                                itemCount: stateProducts.products.length < 8
                                    ? stateProducts.products.length
                                    : 8,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Stack(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: stateProducts
                                                  .products[index]
                                                  .imageUrls
                                                  .first,
                                              width: 120.w,
                                              height: 120.h,
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: IconBox(
                                                scale: 0.44,
                                                onTap: () {
                                                  context
                                                      .read<FavoritesBloc>()
                                                      .add(
                                                        ProductAddedToFavorites(
                                                          id: stateProducts
                                                              .products[index]
                                                              .id,
                                                          name: stateProducts
                                                              .products[index]
                                                              .name,
                                                          category:
                                                              stateProducts
                                                                  .products[
                                                                      index]
                                                                  .category,
                                                          imageUrl:
                                                              stateProducts
                                                                  .products[
                                                                      index]
                                                                  .imageUrls
                                                                  .first,
                                                          price: stateProducts
                                                              .products[index]
                                                              .price,
                                                        ),
                                                      );
                                                },
                                                iconPath: AppIcons.bookmark,
                                                boxColor: AppTheme.primaryColor
                                                    .withOpacity(0.1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(stateProducts.products[index].name,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                      Text(
                                        "\$${stateProducts.products[index].price}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    context.goNamed(searchProductsScreen, extra: []);
                  },
                  icon: Icon(
                    CupertinoIcons.search,
                    color: AppTheme.white,
                  ),
                ),
                title: const Text(
                  'FAVORITES',
                ),
              ),
              body: ScaffoldBody(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(notFound),
                      Text(
                        'No Products Found Unfortunately',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
