import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class ShippingInfo extends StatelessWidget {
  const ShippingInfo({
    Key? key,
    required this.icon,
    required this.title,
    required this.shipping,
    required this.paymentMethod,
    required this.status,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final String shipping;
  final String paymentMethod;
  final String status;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      children: [
        CircleAvatar(
          backgroundColor: AppColor.primaryColor.withOpacity(0.1),
          child: const Icon(Icons.location_on_rounded),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text.rich(
                TextSpan(
                  text: 'Shipping: ',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppColor.captionColor.withOpacity(0.6),
                      ),
                  children: [
                    TextSpan(
                      text: shipping,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text.rich(
                TextSpan(
                  text: 'Payment Method: ',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppColor.captionColor.withOpacity(0.6),
                      ),
                  children: [
                    TextSpan(
                      text: paymentMethod,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text.rich(
                TextSpan(
                  text: 'Status: ',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppColor.captionColor.withOpacity(0.6),
                      ),
                  children: [
                    TextSpan(
                      text: status,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Download',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: AppColor.primaryColor,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
