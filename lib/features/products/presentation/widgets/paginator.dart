import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../../core/theme/colors.dart';

class Paginator extends StatelessWidget {
  const Paginator({
    Key? key,
    required ValueNotifier<int> currentPage,
    required this.length,
    required this.onPageChanged,
  })  : _currentPage = currentPage,
        super(key: key);

  final ValueNotifier<int> _currentPage;
  final int length;
  final void Function(int) onPageChanged;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: _currentPage,
        builder: (context, value, child) {
          return NumberPaginator(
            contentBuilder: (index) => InkWell(
              onTap: () {
                _currentPage.value = index;
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color:
                      index == value ? AppColor.primaryColor : AppColor.white,
                  border: Border.all(
                    color: AppColor.captionColor.withOpacity(0.4),
                  ),
                ),
                child: Text(
                  '${index + 1}',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: index == value ? AppColor.white : AppColor.black,
                      ),
                ),
              ),
            ),
            onPageChange: onPageChanged,
            initialPage: 0,
            config: NumberPaginatorUIConfig(
              mainAxisAlignment: MainAxisAlignment.center,
              mode: ContentDisplayMode.numbers,
              buttonShape: RoundedRectangleBorder(
                side: BorderSide(
                  color: AppColor.captionColor.withOpacity(0.4),
                ),
              ),
              contentPadding: EdgeInsets.zero,
            ),
            controller: NumberPaginatorController(),
            numberPages: length,
          );
        });
  }
}
