import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class CreditCardInfoMobile extends StatelessWidget {
  const CreditCardInfoMobile({
    Key? key,
    required this.cardNumber,
    required this.businnessName,
    required this.phoneNumber,
  }) : super(key: key);
  final String cardNumber;
  final String businnessName;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 0.8,
          color: AppColor.captionColor.withOpacity(0.2),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Payment Method',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColor.captionColor.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Mastercard_2019_logo.svg/1200px-Mastercard_2019_logo.svg.png',
                    height: 25,
                    width: 25,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  cardNumber,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text.rich(
                TextSpan(
                  text: 'Bussiness Name: ',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppColor.captionColor.withOpacity(0.6),
                      ),
                  children: [
                    TextSpan(
                      text: businnessName,
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
                  text: 'Phone Number: ',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppColor.captionColor.withOpacity(0.6),
                      ),
                  children: [
                    TextSpan(
                      text: phoneNumber,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
