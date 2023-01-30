import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wtech_ecommerce/features/store/presentation/widgets/category/categories_overview_widget.dart';

import '../../../../../../core/routes/app_route.dart';
import '../../../domain/entities/category_entity.dart';

class CategoriesOverview extends StatelessWidget {
  const CategoriesOverview({super.key, required this.categories});
  final List<CategoryE> categories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  categories[index].categoryName,
                  style: Theme.of(context).textTheme.headline4,
                ),
                TextButton(
                  onPressed: () {
                    context.pushNamed(
                      productsCategoryScreen,
                      params: {
                        'categoryName': categories[index].categoryName,
                      },
                    );
                  },
                  child: const Text('See all »'),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            CategoriesOverviewWidget(
              products: categories[index].productsOverview,
            ),
          ],
        );
      },
    );
  }
}
