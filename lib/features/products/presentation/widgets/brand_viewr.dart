import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/theme/assets_names.dart';
import '../../../../core/theme/colors.dart';

class BrandsViewer extends StatelessWidget {
  const BrandsViewer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColor.captionColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              'https://www.freepnglogos.com/uploads/microsoft-window-logo-emblem-0.png',
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Lottie.asset(
                  miniLoading,
                  height: 70,
                  width: 70,
                );
              },
              errorBuilder: (context, error, stackTrace) => Lottie.asset(
                notFound,
                height: 180,
                width: 160,
              ),
            ),
          ),
          Text('Microsoft', style: Theme.of(context).textTheme.headline4),
          Text(
            ' (1333 Items)',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppColor.captionColor,
                ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
