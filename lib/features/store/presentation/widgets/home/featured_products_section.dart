// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:wtech_ecommerce/features/store/domain/entities/products_entity.dart';

import '../../../../../core/routes/app_route.dart';

class FeaturedProductsSection extends StatelessWidget {
  const FeaturedProductsSection({
    Key? key,
    required this.products,
  }) : super(key: key);
  final List<ProductsE> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
            primary: false,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 30,
              childAspectRatio: 1 / 1,
            ),
            itemCount: products.length > 8 ? 8 : products.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  context.goNamed(
                    productDetailScreen,
                    params: {'id': products[index].id},
                    extra: products,
                  );
                },
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: products[index].imageUrls.first,
                            width: 130.w,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      products[index].name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      '\$${products[index].price}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              );
            }),
        SizedBox(height: 10.h),
      ],
    );
  }
}
