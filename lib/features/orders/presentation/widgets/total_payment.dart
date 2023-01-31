import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class TotalPayment extends StatelessWidget {
  const TotalPayment({
    Key? key,
    required this.subTotal,
    required this.shippingCost,
    required this.total,
  }) : super(key: key);
  final double subTotal;
  final double shippingCost;
  final double total;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border(
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Subtotal',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: AppColor.captionColor.withOpacity(0.6))),
              Text('Shipping Cost',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: AppColor.captionColor.withOpacity(0.6))),
              Text('Total',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: AppColor.captionColor.withOpacity(0.6))),
            ],
          ),
          const SizedBox(width: 60),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '\$$subTotal',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                '\$$shippingCost',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                '\$$total',
                style: Theme.of(context).textTheme.headline4!,
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColor.green.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Payment Made',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: AppColor.green,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
