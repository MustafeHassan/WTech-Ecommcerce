import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wtech_ecommerce/core/theme/theme.dart';

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
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      padding: EdgeInsets.symmetric(
          horizontal: 20.h, vertical: isPaymentDetail ? 20.w : 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
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
          SizedBox(height: isPaymentDetail ? 0.h : 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/sim.png',
                width: 40.w,
              ),
              cardDate == '-- / --'
                  ? Text(
                      cardDate,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: AppTheme.black,
                          ),
                    )
                  : Text(
                      cardDate,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppTheme.white,
                          ),
                    ),
            ],
          ),
          SizedBox(height: 25.h),
          cardNumber.contains('-')
              ? Text(
                  cardNumber,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: AppTheme.white,
                        letterSpacing: 4,
                      ),
                )
              : Text(
                  cardNumber,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: AppTheme.white,
                      ),
                ),
          SizedBox(height: 10.h),
          Text(
            'Card Holder',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppTheme.white,
                ),
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardHolder,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: AppTheme.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Image.asset(
                'assets/images/master.png',
                width: 40.w,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
