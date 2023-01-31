import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/theme/assets_names.dart';
import '../../../../core/theme/colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.onPressed,
    this.menuTexts,
  }) : super(key: key);
  final String imageUrl;
  final String name;
  final double price;
  final VoidCallback? onPressed;
  final List<String>? menuTexts;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 270,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 13.0,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 0.6,
            color: AppColor.captionColor.withOpacity(
              0.3,
            ),
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Lottie.asset(miniLoading, height: 70, width: 70);
              },
              height: 160,
              width: 190,
              errorBuilder: (context, error, stackTrace) => Lottie.asset(
                notFound,
                height: 180,
                width: 160,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      '\$$price',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.all((10)),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.captionColor.withOpacity(.3),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: PopupMenuButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  position: PopupMenuPosition.under,
                  child: const Icon(
                    Icons.edit,
                    size: 15,
                  ),
                  itemBuilder: (context) {
                    return List.generate(
                      3,
                      (index) => PopupMenuItem(
                        height: 10,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 4),
                        child: Text(
                          menuTexts?[index] ?? 'N/A',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ).toList();
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
