import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme.dart';

class PageIndicatorWidget extends StatelessWidget {
  const PageIndicatorWidget({Key? key, required this.pageIndex, this.count})
      : super(key: key);
  final int pageIndex;
  final int? count;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          count ?? 3,
          (index) => AnimatedContainer(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            width: pageIndex == index ? 9.w : 6.w,
            height: pageIndex == index ? 9.w : 6.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: pageIndex == index
                  ? Theme.of(context).primaryColor
                  : AppTheme.borderColor,
            ),
          ),
        ),
      ],
    );
  }
}
