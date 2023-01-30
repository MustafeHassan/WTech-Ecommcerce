// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wtech_ecommerce/core/functions/snackbars.dart';
import 'package:wtech_ecommerce/core/theme/theme.dart';

import 'package:wtech_ecommerce/features/store/domain/entities/products_entity.dart';

import '../../../../../core/routes/app_route.dart';
import '../../../domain/entities/brands_entity.dart';

class BrandsSection extends StatelessWidget {
  const BrandsSection({
    Key? key,
    required this.brands,
    required this.products,
  }) : super(key: key);
  final List<BrandsE> brands;
  final List<ProductsE>? products;

  @override
  Widget build(BuildContext context) {
    brands.shuffle();
    return Column(
      children: [
        SizedBox(
          height: 213.h,
          child: ListView.builder(
            itemCount: brands.length > 5 ? 5 : brands.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: InkWell(
                  onTap: () {
                    if (products == null) {
                      showSnackBar(
                        context: context,
                        iconData: Icons.info,
                        title: 'No products found for this brand',
                        statusColor: AppTheme.red,
                      );
                    } else {
                      context.goNamed(
                        brandProductsScreen,
                        params: {
                          'brandName': brands[index].brandName,
                        },
                        extra: products,
                      );
                    }
                  },
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: brands[index].brandImageUrl,
                        width: 120.w,
                        height: 120.h,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        brands[index].brandName,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
