import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../theme/colors.dart';

class CustomButtonConsumer extends StatelessWidget {
  const CustomButtonConsumer({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, formGroup, _) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fixedSize: Size(width ?? 270, 44),
          ),
          onPressed: formGroup.valid ? onPressed : null,
          child: Text(
            text,
            style: Theme.of(context).textTheme.button,
          ),
        );
      },
    );
  }
}

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({
    Key? key,
    required this.text,
    this.onPressed,
    this.iconData,
    this.width,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final IconData? iconData;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return iconData != null
        ? ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(150, 40),
              elevation: 1.2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: onPressed,
            icon: Icon(
              iconData,
              color: AppColor.white,
            ),
            label: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppColor.white,
                  ),
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(width ?? 150, 40),
              elevation: 1.2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppColor.white,
                  ),
            ),
          );
  }
}

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({
    Key? key,
    required this.text,
    this.onPressed,
    this.iconData,
    this.width,
    this.height,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final IconData? iconData;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return iconData != null
        ? ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(width ?? 120, height ?? 40),
              backgroundColor: AppColor.white,
              elevation: 1.2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: onPressed,
            icon: Icon(
              iconData,
              color: AppColor.captionColor.withOpacity(0.6),
            ),
            label: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(120, 40),
              backgroundColor: AppColor.white,
              elevation: 1.2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          );
  }
}
