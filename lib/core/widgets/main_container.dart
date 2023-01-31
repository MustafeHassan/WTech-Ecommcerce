import 'package:flutter/material.dart';

import '../theme/colors.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.border = false,
    this.addPadding = true,
    this.addMargin = true,
  }) : super(key: key);
  final Widget child;
  final double? width;
  final double? height;
  final bool border;
  final bool addPadding;
  final bool addMargin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: addMargin ? const EdgeInsets.symmetric(vertical: 15) : null,
      padding: addPadding
          ? const EdgeInsets.symmetric(vertical: 20, horizontal: 15)
          : EdgeInsets.zero,
      height: height ?? 300,
      decoration: BoxDecoration(
        color: AppColor.white,
        // borderRadius: BorderRadius.circular(10),
        border: border
            ? Border.all(
                color: AppColor.captionColor.withOpacity(0.2),
              )
            : null,
      ),
      child: child,
    );
  }
}
