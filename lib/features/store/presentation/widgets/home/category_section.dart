import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/app_route.dart';
import '../../../domain/entities/category_entity.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key, required this.categories});
  final List<CategoryE> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 213.h,
          child: ListView.builder(
            itemCount: categories.length > 4 ? 4 : categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  context.pushNamed(
                    productsCategoryScreen,
                    params: {
                      'categoryName': categories[index].categoryName,
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.0.w,
                  ),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: categories[index].categoryImageUrl,
                        width: 120.w,
                        height: 120.h,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        categories[index].categoryName,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
