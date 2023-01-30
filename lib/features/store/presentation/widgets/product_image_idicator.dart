import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/theme.dart';

class ProductImageIdicator extends StatelessWidget {
  const ProductImageIdicator(
      {Key? key, required this.imageIndex, required this.imageCount})
      : super(key: key);
  final int imageIndex;
  final int imageCount;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          imageCount,
          (index) => AnimatedContainer(
            margin: EdgeInsets.symmetric(vertical: 10.w),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            width: imageIndex == index ? 9.w : 6.w,
            height: imageIndex == index ? 9.w : 6.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: imageIndex == index
                  ? Theme.of(context).primaryColor
                  : AppTheme.borderColor,
            ),
          ),
        ),
      ],
    );
  }
}
