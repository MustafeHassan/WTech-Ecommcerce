import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wtech_dashboard/core/routes/app_routes.dart';

import '../../../../core/theme/colors.dart';

class SideMenuListTileWithExpantion extends StatelessWidget {
  const SideMenuListTileWithExpantion({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
    this.isSelected,
    required this.texts,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool? isSelected;
  final List<String> texts;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 8.0,
      ),
      child: ListTile(
        horizontalTitleGap: -12,
        onTap: onTap,
        hoverColor: isSelected == true
            ? AppColor.primaryColor.withOpacity(0.1)
            : AppColor.captionColor.withOpacity(0.1),
        selectedTileColor: AppColor.primaryColor.withOpacity(0.1),
        selected: isSelected ?? false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        leading: Icon(
          icon,
          color: isSelected == true
              ? AppColor.primaryColor
              : AppColor.captionColor.withOpacity(0.5),
        ),
        title: ExpansionTile(
          trailing: null,
          onExpansionChanged: isSelected == true ? (value) {} : null,
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: isSelected == true
                      ? AppColor.primaryColor
                      : AppColor.captionColor.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
          ),
          expandedAlignment: Alignment.centerLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            texts.length,
            (index) => TextButton(
              onPressed: isSelected == true
                  ? () {
                      if (texts[index] == 'Add project') {
                        context.pushNamed(addProductScreen);
                      } else if (texts[index] == 'Categories') {
                        context.pushNamed(categoriesScreen);
                      } else if (texts[index] == 'Brands') {
                        context.pushNamed(brandsScreen);
                      } else if (texts[index] == 'Product list') {
                        context.goNamed(productsScreen);
                      }
                    }
                  : null,
              child: Text(
                texts[index],
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
