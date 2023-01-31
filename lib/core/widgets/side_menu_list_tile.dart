import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class SideMenuListTile extends StatelessWidget {
  const SideMenuListTile({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
    this.isSelected,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool? isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 8.0,
      ),
      child: ListTile(
        horizontalTitleGap: 0,
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
        trailing: Visibility(
          visible: false,
          child: CircleAvatar(
            backgroundColor: AppColor.red,
            radius: 10,
            child: Text(
              '4',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: AppColor.white,
                  ),
            ),
          ),
        ),
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
      ),
    );
  }
}
