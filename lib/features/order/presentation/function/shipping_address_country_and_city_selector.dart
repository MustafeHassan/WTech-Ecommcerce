import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/theme/theme.dart';

Future<dynamic> shippingCountryAndCitySelector({
  required BuildContext context,
  required List<String> countryAndCity,
  required bool isCountry,
  required FormGroup shippingAddress,
  required ValueNotifier<int> cityIndex,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: 80.w,
          height: 5.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: AppTheme.borderColor,
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  cityIndex.value = index;
                  isCountry
                      ? shippingAddress.controls['Country']!
                          .updateValue(countryAndCity[index])
                      : shippingAddress.controls['City']!
                          .updateValue(countryAndCity[index]);
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        countryAndCity[index],
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      shippingAddress.controls['Country']?.value.toString() ==
                              countryAndCity[index]
                          ? const Icon(Icons.check)
                          : const SizedBox(),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: countryAndCity.length,
          ),
        ),
      ],
    ),
  );
}
