import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class OrderedProducts extends StatelessWidget {
  const OrderedProducts({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.quantity,
    required this.unitTotal,
    required this.total,
    this.topBorder = false,
  }) : super(key: key);
  final String imageUrl;
  final String name;
  final int quantity;
  final double unitTotal;
  final double total;
  final bool topBorder;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border(
          top: topBorder
              ? BorderSide(
                  color: AppColor.captionColor.withOpacity(0.3),
                )
              : BorderSide.none,
          left: BorderSide(
            color: AppColor.captionColor.withOpacity(0.3),
          ),
          right: BorderSide(
            color: AppColor.captionColor.withOpacity(0.3),
          ),
          bottom: BorderSide(
            color: AppColor.captionColor.withOpacity(0.3),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Image.network(
                  imageUrl,
                  height: 30,
                  width: 50,
                ),
                const SizedBox(width: 25),
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: AppColor.primaryColor,
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              '$quantity',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Expanded(
            child: Text(
              '\$$unitTotal',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              '\$$total',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
