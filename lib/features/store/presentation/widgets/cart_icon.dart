import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/theme.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({
    Key? key,
    required this.itemCount,
    required this.onPressed,
    this.isWhiteColor = false,
  }) : super(key: key);
  final int itemCount;
  final VoidCallback onPressed;
  final bool isWhiteColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        width: 30.w,
        child: Stack(
          children: [
            isWhiteColor
                ? SvgPicture.asset(
                    AppIcons.shoppingWhite,
                    width: 16.w,
                    height: 20.h,
                  )
                : SvgPicture.asset(
                    AppIcons.shopping,
                    width: 16.w,
                    height: 20.h,
                  ),
            Visibility(
              visible: itemCount == 0 ? false : true,
              child: Positioned(
                bottom: 10,
                right: 4,
                child: CircleAvatar(
                  radius: 9.r,
                  child: Text(
                    '$itemCount',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
