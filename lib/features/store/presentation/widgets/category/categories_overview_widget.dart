import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/app_route.dart';
import '../discount_box.dart';

class CategoriesOverviewWidget extends StatelessWidget {
  const CategoriesOverviewWidget({super.key, required this.products});
  final List<dynamic> products;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 213.h,
          child: ListView.builder(
            itemCount: products.length > 4 ? 4 : products.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  if ((products[index] as Map<String, dynamic>)
                      .containsKey('id')) {
                    context.pushNamed(
                      productDetailScreen,
                      params: {'id': products[index].id},
                      extra: products,
                    );
                  } else {
                    debugPrint('No ID');
                    return;
                  }
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: products[index]['imageUrl'],
                          width: 110.w,
                          height: 110.h,
                        ),
                        const Positioned(
                          right: 0,
                          child: DiscountBox(
                            discount: 10,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 200.w,
                      child: Text(
                        products[index]['name'],
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(
                      '\$${products[index]['price']}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
