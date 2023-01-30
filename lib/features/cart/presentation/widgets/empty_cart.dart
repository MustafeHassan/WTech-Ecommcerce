import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/scaffold_body.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black,
      appBar: AppBar(
        title: const Text(
          'CART',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24.0.h, right: 24.h, top: 24.h),
            child: Text(
              'Seems like you don’t have any items \n in your cart list.',
              style: Theme.of(context).textTheme.button!.copyWith(
                    color: AppTheme.borderColor,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: ScaffoldBody(
              lessHight: true,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 10),
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: SvgPicture.asset('assets/images/empty_cart.svg'),
                    ),
                    Text(
                      'NO PRODCUTS ADDED YET',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w100,
                          ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
