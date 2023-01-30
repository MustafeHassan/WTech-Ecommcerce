// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wtech_ecommerce/core/functions/snackbars.dart';

import 'package:wtech_ecommerce/features/store/domain/entities/category_entity.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/scaffold_body.dart';

class FilterAndSortScreen extends StatelessWidget {
  const FilterAndSortScreen({
    Key? key,
    required this.categoryNames,
  }) : super(key: key);
  final List<CategoryE> categoryNames;
  static final ValueNotifier<int> _categoreyChipIndex = ValueNotifier(0);
  static final ValueNotifier<int> _watchesChipIndex = ValueNotifier(0);
  static final ValueNotifier<RangeValues> _priceRange = ValueNotifier(
    const RangeValues(1.0, 2000.0),
  );

  static const List<String> _watchesSortChip = [
    'Price',
    'Popularity',
    'Top Selling',
    'Rating',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text(
          'FILTER & SORT',
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.clear,
              color: AppTheme.white,
            ),
          ),
          SizedBox(width: 10.h),
        ],
      ),
      body: ScaffoldBody(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Text(
                'Select Categories',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w200,
                    ),
              ),
              SizedBox(height: 20.h),
              ValueListenableBuilder(
                valueListenable: _categoreyChipIndex,
                builder: (BuildContext context, int value, Widget? child) {
                  return Wrap(
                    spacing: 12,
                    runSpacing: 10,
                    children: List.generate(
                      categoryNames.length,
                      (index) => ChoiceChip(
                        selectedColor: AppTheme.primaryColor,
                        backgroundColor: AppTheme.borderColor.withOpacity(0.1),
                        label: Text(
                          categoryNames[index].categoryName,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w100,
                                    color: value == index
                                        ? AppTheme.white
                                        : AppTheme.black,
                                  ),
                        ),
                        selected: value == index,
                        onSelected: (_) {
                          _categoreyChipIndex.value = index;
                        },
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 30.h),
              Text(
                'Sort watches by',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w100,
                    ),
              ),
              SizedBox(height: 30.h),
              ValueListenableBuilder(
                valueListenable: _watchesChipIndex,
                builder: (BuildContext context, int value, Widget? child) {
                  return Wrap(
                    spacing: 12,
                    runSpacing: 10,
                    children: List.generate(
                      _watchesSortChip.length,
                      (index) => ChoiceChip(
                        selectedColor: AppTheme.primaryColor,
                        backgroundColor: AppTheme.borderColor.withOpacity(0.1),
                        label: Text(
                          _watchesSortChip[index],
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w100,
                                    color: value == index
                                        ? AppTheme.white
                                        : AppTheme.black,
                                  ),
                        ),
                        selected: value == index,
                        onSelected: (_) {
                          _watchesChipIndex.value = index;
                        },
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 30.h),
              Text(
                'Select a price range ',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w100,
                    ),
              ),
              SizedBox(height: 30.h),
              ValueListenableBuilder(
                valueListenable: _priceRange,
                builder: (BuildContext context, RangeValues rangeValue,
                    Widget? child) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                              '\$${_priceRange.value.start.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.bodyText1!),
                          Text('\$${_priceRange.value.end.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.bodyText1!),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      RangeSlider(
                        inactiveColor: AppTheme.borderColor.withOpacity(0.1),
                        min: 1.0,
                        max: 5000.0,
                        values: rangeValue,
                        onChanged: (RangeValues newValue) {
                          _priceRange.value = newValue;
                        },
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 15.h),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showSnackBar(
                      context: context,
                      iconData: Icons.info,
                      title: 'This Feature Not Available',
                      statusColor: AppTheme.captionColor,
                    );
                  },
                  child: Text(
                    'APPLY',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        AppTheme.primaryColor.withOpacity(0.4)),
                  ),
                  onPressed: () {
                    _watchesChipIndex.value = 0;
                    _categoreyChipIndex.value = 0;
                    _priceRange.value = const RangeValues(1.0, 5000);
                  },
                  child: Text(
                    'CLEAR FILTERS',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: AppTheme.black,
                          letterSpacing: 1.3,
                        ),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
