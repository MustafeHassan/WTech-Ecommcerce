import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CreditCards extends StatelessWidget {
  const CreditCards({
    Key? key,
    required this.cardDate,
    required this.cardNumber,
    required this.cardHolder,
    this.isPaymentDetail = false,
  }) : super(key: key);
  final String cardDate, cardNumber, cardHolder;
  final bool isPaymentDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(
          horizontal: 20, vertical: isPaymentDetail ? 20 : 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          end: Alignment.topLeft,
          begin: Alignment.bottomRight,
          colors: [
            Color(0xFF61626C),
            Color(0xFF43444F),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: isPaymentDetail ? 0 : 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/sim.png',
                width: 40,
              ),
              cardDate == '-- / --'
                  ? Text(
                      cardDate,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: AppColor.black,
                          ),
                    )
                  : Text(
                      cardDate,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppColor.white,
                          ),
                    ),
            ],
          ),
          const SizedBox(height: 25),
          cardNumber.contains('-')
              ? Text(
                  cardNumber,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: AppColor.white,
                        letterSpacing: 4,
                      ),
                )
              : Text(
                  cardNumber,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: AppColor.white,
                      ),
                ),
          const SizedBox(height: 10),
          Text(
            'Card Holder',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppColor.white,
                ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardHolder,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Image.asset(
                'assets/images/master.png',
                width: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
