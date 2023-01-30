// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:wtech_ecommerce/core/routes/app_route.dart';

import '../../../../core/theme/animations_asset.dart';
import '../../domain/entities/products_entity.dart';

class SimilarProdcuts extends StatelessWidget {
  const SimilarProdcuts({
    Key? key,
    required this.similarProducts,
  }) : super(key: key);
  final List<ProductsE> similarProducts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 213.h,
      child: ListView.builder(
        itemCount: similarProducts.length > 5 ? 5 : similarProducts.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: InkWell(
              onTap: () {
                GoRouter.of(context).replaceNamed(
                  productDetailScreen,
                  params: {"id": similarProducts[index].id},
                  extra: similarProducts,
                );
              },
              child: Column(
                children: [
                  CachedNetworkImage(
                    placeholder: (context, url) => Lottie.asset(
                      imageLoading,
                      width: 80.w,
                      height: 80.h,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/failed_image.jpg',
                    ),
                    imageUrl: similarProducts[index].imageUrls.first,
                    width: 120.w,
                    height: 120.h,
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      similarProducts[index].name,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  Text(
                    "\$${similarProducts[index].price}",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
