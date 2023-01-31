import 'package:flutter/material.dart';

import '../theme/colors.dart';

class DropDownButtonCustom extends StatelessWidget {
  const DropDownButtonCustom({
    Key? key,
    required this.menutItems,
    this.iconData,
    required this.hintText,
    this.width,
    this.height,
  }) : super(key: key);

  final IconData? iconData;
  final List<dynamic> menutItems;
  final String hintText;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColor.captionColor.withOpacity(.3),
        ),
      ),
      child: DropdownButton<dynamic>(
        isExpanded: width != null,
        alignment: width != null ? Alignment.centerLeft : Alignment.center,
        isDense: true,
        underline: Container(),
        icon: Icon(
          iconData ?? Icons.keyboard_arrow_down_outlined,
          color: AppColor.captionColor.withOpacity(0.4),
        ),
        hint: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(hintText, style: Theme.of(context).textTheme.bodyText1),
        ),
        borderRadius: BorderRadius.circular(5),
        items: menutItems
            .map<DropdownMenuItem<dynamic>>(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            )
            .toList(),
        onChanged: (_) {},
      ),
    );
  }
}
