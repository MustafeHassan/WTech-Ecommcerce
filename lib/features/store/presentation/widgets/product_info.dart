import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/theme.dart';

class ProductInformation extends StatelessWidget {
  const ProductInformation(
      {Key? key,
      required this.name,
      required this.description,
      required this.rating,
      required this.price,
      required this.totalRating})
      : super(key: key);
  final String name, description;
  final num rating, price;
  final int totalRating;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.headline2,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RatingBarIndicator(
              itemSize: 20,
              unratedColor: Theme.of(context).primaryColor.withOpacity(0.3),
              itemCount: 5,
              rating: rating.toDouble(),
              itemBuilder: (context, index) {
                return Icon(
                  Icons.star,
                  color: AppTheme.primaryColor,
                );
              },
            ),
            SizedBox(width: 10.w),
            Text(
              '$totalRating Reviews',
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        SizedBox(height: 25.h),
        Text(
          description,
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 25.h),
        Text(
          '\$$price',
          style: Theme.of(context).textTheme.headline2!.copyWith(
                color: AppTheme.primaryColor,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
