import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconBox extends StatelessWidget {
  const IconBox({
    Key? key,
    required this.boxColor,
    this.onTap,
    required this.iconPath,
    this.scale,
  }) : super(key: key);
  final Color boxColor;
  final VoidCallback? onTap;
  final String iconPath;

  final double? scale;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 35.r,
        height: 35.r,
        decoration: BoxDecoration(
          color: boxColor,
          shape: BoxShape.circle,
        ),
        child: Transform.scale(
          scale: scale ?? 0.58,
          child: SvgPicture.asset(iconPath),
        ),
      ),
    );
  }
}
