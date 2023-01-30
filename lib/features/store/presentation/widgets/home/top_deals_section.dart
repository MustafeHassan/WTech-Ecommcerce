import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:wtech_ecommerce/features/store/domain/entities/products_entity.dart';
import 'package:wtech_ecommerce/features/store/presentation/widgets/home/top_deals.dart';

import '../../../../../core/routes/app_route.dart';

class TopDealsSection extends StatelessWidget {
  const TopDealsSection({
    Key? key,
    required this.topDeals,
  }) : super(key: key);
  final List<ProductsE> topDeals;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 210.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: topDeals.length > 4 ? 4 : topDeals.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  context.goNamed(
                    productDetailScreen,
                    params: {
                      'id': topDeals[index].id,
                    },
                    extra: topDeals,
                  );
                },
                child: TopDeals(
                  imageUrl: topDeals[index].imageUrls[0],
                  name: topDeals[index].brand,
                  description: topDeals[index].name,
                  price: topDeals[index].price.toString(),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
