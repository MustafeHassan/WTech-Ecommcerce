import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/theme.dart';

class Specification extends StatelessWidget {
  const Specification({
    Key? key,
    required this.specificationsTitle,
    required this.specificationsValue,
  }) : super(key: key);
  final List<String> specificationsTitle;
  final List<dynamic> specificationsValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        ...List.generate(
          specificationsTitle.length,
          (index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        specificationsTitle[index],
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Text(
                        specificationsValue[index].toString().trim(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                Divider(color: AppTheme.borderColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
