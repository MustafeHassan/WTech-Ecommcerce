// ignore_for_file: public_member_api_docs, sort_constructors_first, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:wtech_ecommerce/core/routes/app_route.dart';
import 'package:wtech_ecommerce/core/theme/animations_asset.dart';
import 'package:wtech_ecommerce/features/cart/domain/entities/cart_entity.dart';
import 'package:wtech_ecommerce/features/favorites/presentation/bloc/favorites_bloc.dart';

import 'package:wtech_ecommerce/features/store/domain/entities/products_entity.dart';
import 'package:wtech_ecommerce/features/store/presentation/widgets/product_info.dart';

import '../../../../core/functions/snackbars.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/theme.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../widgets/cart_icon.dart';
import '../widgets/icon_box.dart';
import '../widgets/product_image_idicator.dart';
import '../widgets/review_section.dart';
import '../widgets/similart_prodcuts.dart';
import '../widgets/specification_section.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    Key? key,
    required this.product,
    required this.productId,
  }) : super(key: key);

  final List<ProductsE> product;
  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<int> _imageIndex = ValueNotifier(0);
  final ValueNotifier<int> _tabBarIndex = ValueNotifier(0);
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var productDetail = widget.product.firstWhere(
      (element) => element.id == widget.productId,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.keyboard_backspace_outlined,
            color: AppTheme.black,
          ),
        ),
        title: Text(
          'PRODUCT DETAILS',
          style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                color: AppTheme.black,
                letterSpacing: 2,
                fontWeight: FontWeight.w300,
              ),
        ),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return CartIcon(
                itemCount:
                    state.cartItems.isNotEmpty ? state.cartItems.length : 0,
                onPressed: () {
                  context.pushNamed(
                    cartScreen,
                  );
                },
              );
            },
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
          }
        },
        child: Column(
          children: [
            SizedBox(
              height: 315.h,
              child: Row(
                children: [
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (value) {
                        _imageIndex.value = value;
                      },
                      scrollDirection: Axis.vertical,
                      itemCount: productDetail.imageUrls.length,
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          placeholder: (context, url) => Lottie.asset(
                            imageLoading,
                            width: 40.w,
                            height: 40.h,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/failed_image.jpg',
                          ),
                          imageUrl: productDetail.imageUrls[index],
                        );
                      },
                    ),
                  ),
                  ValueListenableBuilder<int>(
                    valueListenable: _imageIndex,
                    builder: (context, value, child) {
                      return ProductImageIdicator(
                        imageIndex: value,
                        imageCount: productDetail.imageUrls.length,
                      );
                    },
                  ),
                  SizedBox(width: 20.w),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(height: 15.h),
                    ProductInformation(
                      name: productDetail.name,
                      description: productDetail.typeDescription,
                      rating: productDetail.averageRating,
                      price: productDetail.price,
                      totalRating: productDetail.totalRating,
                    ),
                    SizedBox(height: 25.h),
                    TabBar(
                      isScrollable: true,
                      tabs: [
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.headline3!,
                        ),
                        Text(
                          'Specifications',
                          style: Theme.of(context).textTheme.headline3!,
                        ),
                        Text(
                          'Reviews',
                          style: Theme.of(context).textTheme.headline3!,
                        ),
                      ],
                      controller: _tabController,
                      onTap: (index) {
                        _tabBarIndex.value = index;
                      },
                    ),
                    ValueListenableBuilder<int>(
                      valueListenable: _tabBarIndex,
                      builder: (context, value, child) {
                        if (value == 0) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0.h),
                            child: Text(
                              productDetail.description,
                              style: Theme.of(context).textTheme.caption,
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else if (value == 1) {
                          return Specification(
                            specificationsTitle:
                                productDetail.specification.keys.toList(),
                            specificationsValue:
                                productDetail.specification.values.toList(),
                          );
                        } else {
                          if (productDetail.allReviews.isEmpty) {
                            return const SizedBox();
                          } else {
                            return Column(
                              children: [
                                SizedBox(height: 15.h),
                                ...List.generate(
                                  productDetail.allReviews.length,
                                  (index) {
                                    var imageUrl = productDetail
                                        .allReviews[index]['imageUrl'];
                                    var userName = productDetail
                                        .allReviews[index]['userName'];
                                    var rating = productDetail.allReviews[index]
                                        ['rating'];
                                    var comment = productDetail
                                        .allReviews[index]['comment'];
                                    var date = productDetail.allReviews[index]
                                        ['commentDate'];
                                    return Review(
                                      userName: userName ?? 'Unknown',
                                      imageUrl: imageUrl ?? AppIcons.imageGrey,
                                      comment: comment ?? '',
                                      rating: rating ?? 0.0,
                                      date: date ?? DateTime.now(),
                                    );
                                  },
                                ),
                              ],
                            );
                          }
                        }
                      },
                    ),
                    //!: may add review section where user can submit their review
                    SizedBox(height: 25.h),
                    Text(
                      'Similar Prodcuts',
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15.h),
                    SimilarProdcuts(
                      similarProducts: widget.product
                          .where(
                            (element) =>
                                element.category == productDetail.category,
                          )
                          .toList(),
                    ),
                    SizedBox(height: 35.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconBox(
                          onTap: () {
                            context.read<FavoritesBloc>().add(
                                  ProductAddedToFavorites(
                                    id: productDetail.id,
                                    name: productDetail.name,
                                    category: productDetail.category,
                                    imageUrl: productDetail.imageUrls.first,
                                    price: productDetail.price,
                                  ),
                                );
                          },
                          boxColor: AppTheme.captionColor.withOpacity(0.1),
                          iconPath: AppIcons.bookmark,
                          scale: 0.44,
                        ),
                        SizedBox(width: 5.w),
                        ElevatedButton(
                          onPressed: () {
                            context.read<CartBloc>().add(
                                  ProductAddedToCart(
                                    item: CartItem(
                                      id: productDetail.id,
                                      name: productDetail.name,
                                      brand: productDetail.brand,
                                      category: productDetail.category,
                                      imageUrl: productDetail.imageUrls.first,
                                      price: productDetail.price,
                                      color:
                                          productDetail.specification['Color'],
                                    ),
                                  ),
                                );
                          },
                          child: Text(
                            'ADD TO CART',
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        IconBox(
                          //? I dont know what to with this
                          onTap: () {},
                          boxColor: AppTheme.captionColor.withOpacity(0.1),
                          iconPath: AppIcons.share,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
