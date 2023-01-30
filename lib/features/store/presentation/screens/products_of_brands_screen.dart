// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:wtech_ecommerce/features/store/domain/entities/products_entity.dart';

import '../../../../core/functions/snackbars.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/drawer.dart';
import '../../../../core/widgets/drawer_icon.dart';
import '../../../../core/widgets/scaffold_body.dart';

import '../../../favorites/presentation/bloc/favorites_bloc.dart';
import '../widgets/icon_box.dart';

class AllProductsOfBrandScreen extends StatelessWidget {
  const AllProductsOfBrandScreen({
    Key? key,
    required this.allProducts,
    required this.brandName,
  }) : super(key: key);
  final List<ProductsE> allProducts;
  final String brandName;

  @override
  Widget build(BuildContext context) {
    var allBrandProducts =
        allProducts.where((element) => element.brand == brandName).toList();
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        leading: const DrawerOpen(),
        title: Text(brandName),
        actions: [
          SizedBox(width: 10.w),
          IconButton(
            onPressed: () {
              context.pushNamed(
                searchProductsScreen,
                extra: allProducts,
              );
            },
            icon: Icon(
              CupertinoIcons.search,
              color: AppTheme.white,
            ),
          ),
          SizedBox(width: 15.w),
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
        child: ScaffoldBody(
          child: Column(
            children: [
              SizedBox(height: 30.h),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 30,
                      childAspectRatio: 1 / 1,
                    ),
                    itemCount: allBrandProducts.length,
                    itemBuilder: (context, index) {
                      return DelayedDisplay(
                        delay: const Duration(milliseconds: 90),
                        fadingDuration: const Duration(milliseconds: 350),
                        slidingBeginOffset: Offset.fromDirection(3.2),
                        slidingCurve: Curves.easeInOut,
                        child: InkWell(
                          onTap: () {
                            context.goNamed(
                              productDetailScreen,
                              params: {'id': allBrandProducts[index].id},
                              extra: allProducts,
                            );
                          },
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Stack(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: allBrandProducts[index]
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
                                          context.read<FavoritesBloc>().add(
                                                ProductAddedToFavorites(
                                                  id: allBrandProducts[index]
                                                      .id,
                                                  name: allBrandProducts[index]
                                                      .name,
                                                  category:
                                                      allBrandProducts[index]
                                                          .category,
                                                  imageUrl:
                                                      allBrandProducts[index]
                                                          .imageUrls
                                                          .first,
                                                  price: allBrandProducts[index]
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
                                allBrandProducts[index].name,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                '\$${allBrandProducts[index].price}',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
