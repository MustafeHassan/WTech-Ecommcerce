import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/theme.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({
    Key? key,
    required this.statusComplete,
    this.isLastLine = false,
    required this.title,
    required this.orderPlacedDate,
    required this.orderId,
  }) : super(key: key);
  final String title;
  final bool statusComplete;
  final bool isLastLine;

  final String orderPlacedDate;
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: statusComplete == true
                  ? AppTheme.primaryColor
                  : AppTheme.borderColor.withOpacity(0.0),
              border: statusComplete == true
                  ? const Border()
                  : Border.all(
                      color: AppTheme.borderColor.withOpacity(0.3),
                    ),
            ),
            child: statusComplete == true
                ? Icon(
                    Icons.check,
                    size: 15,
                    color: AppTheme.white,
                  )
                : const SizedBox(),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w100,
                ),
          ),
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: isLastLine ? 55 : 35,
          children: [
            Visibility(
              visible: !isLastLine,
              child: Container(
                margin: const EdgeInsets.only(
                  left: 15,
                  right: 4,
                  bottom: 10,
                ),
                height: 64.h,
                width: 1.w,
                color: AppTheme.borderColor.withOpacity(0.5),
              ),
            ),
            Text(
              title == 'Order Placed'
                  ? 'Your order $orderId was placed on\n$orderPlacedDate.'
                  : title == 'Proccessing'
                      ? 'Your order still needs to be processed by\nour store before sending it to you.'
                      : title == 'Picked up by the courier'
                          ? 'Your order has been picked up by one of\nour couriers and its on your way.'
                          : title == 'Delivering'
                              ? 'The package is on your way. Make sure\nto be at the location to meet the courier.'
                              : 'It seems like the package has arrived to\nyou. Hope you are happy with it!', //*Title is Delivered
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ],
    );
  }
}
