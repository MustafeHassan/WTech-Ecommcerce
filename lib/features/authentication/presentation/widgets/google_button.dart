import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/theme.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key, this.onPressed}) : super(key: key);
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: MaterialStateProperty.all(BorderSide(color: AppTheme.red)),
      ),
      child: Wrap(
        spacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SvgPicture.asset(
            AppIcons.googleRed,
            width: 20.w,
            height: 20.h,
          ),
          Text(
            'Continue with Google',
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: AppTheme.red),
          ),
        ],
      ),
    );
  }
}
