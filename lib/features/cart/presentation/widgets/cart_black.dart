import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/theme.dart';

class BlackCartCard extends StatelessWidget {
  const BlackCartCard({
    Key? key,
    required this.name,
    required this.productColor,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.increase,
    required this.descrease,
    this.canQuantityDescrease = false,
  }) : super(key: key);
  final String imageUrl, name, productColor;
  final double price;
  final VoidCallback increase, descrease;
  final int quantity;
  final bool canQuantityDescrease;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppTheme.black,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 120.h,
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 50.w,
              height: 50.h,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: AppTheme.white,
                      ),
                ),
                const Spacer(),
                Text(
                  'Color: $productColor',
                  style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                        fontSize: 13.sp,
                      ),
                ),
                const Spacer(),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: Theme.of(context)
                      .appBarTheme
                      .titleTextStyle!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 16.sp),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
          // const Spacer(),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              IconButton(
                onPressed: increase,
                tooltip: 'Add Quantity',
                icon: const Icon(Icons.add),
              ),
              Text(
                '$quantity',
                style: Theme.of(context).appBarTheme.titleTextStyle!.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Visibility(
                visible: !canQuantityDescrease,
                child: IconButton(
                  onPressed: descrease,
                  tooltip: 'Remove Quantity',
                  icon: const Icon(Icons.remove),
                ),
              ),
              !canQuantityDescrease ? const SizedBox() : SizedBox(width: 12.w),
            ],
          ),
        ],
      ),
    );
  }
}
