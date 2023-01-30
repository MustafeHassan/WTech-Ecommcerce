import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/theme.dart';

class TopDeals extends StatelessWidget {
  const TopDeals({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
  }) : super(key: key);
  final String imageUrl, name, description, price;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 12, left: 30),
          width: 315.w,
          height: 160.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 34, 25, 153),
                Color(0xFF272833),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: AppTheme.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 8.h),
              Text(
                description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppTheme.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 20.h),
              Text(
                '\$$price',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: AppTheme.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 185, bottom: 0),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            width: 180.w,
            height: 180.h,
          ),
        ),
      ],
    );
  }
}
