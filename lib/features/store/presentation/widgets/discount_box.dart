import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/theme.dart';

class DiscountBox extends StatelessWidget {
  const DiscountBox({
    Key? key,
    required this.discount,
  }) : super(key: key);
  final int discount;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 39.w,
      height: 24.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5.r),
          bottomLeft: Radius.circular(5.r),
        ),
      ),
      child: Text(
        '-$discount%',
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: AppTheme.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
