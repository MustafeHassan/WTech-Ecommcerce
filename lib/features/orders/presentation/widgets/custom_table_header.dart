import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class CustomTableHeader extends StatelessWidget {
  const CustomTableHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColor.captionColor.withOpacity(0.3),
          ),
          left: BorderSide(
            color: AppColor.captionColor.withOpacity(0.3),
          ),
          right: BorderSide(
            color: AppColor.captionColor.withOpacity(0.3),
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              'Product',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          Expanded(
            child: Text(
              'Quantity',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          Expanded(
            child: Text(
              'Unit Price',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              'Total',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
      ),
    );
  }
}
