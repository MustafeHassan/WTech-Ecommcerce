import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/theme.dart';

class Review extends StatelessWidget {
  const Review({
    Key? key,
    this.imageUrl,
    required this.userName,
    required this.comment,
    required this.date,
    required this.rating,
  }) : super(key: key);
  final String? imageUrl;
  final String userName, comment;
  final DateTime date;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
          leading: Container(
            width: 50.r,
            height: 50.r,
            decoration: BoxDecoration(
              color: AppTheme.captionColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: imageUrl == null
                ? Transform.scale(
                    scale: 0.55,
                    child: Image.asset(
                      AppIcons.imageGrey,
                    ),
                  )
                : Image.asset(
                    imageUrl!,
                  ),
          ),
          title: Text(
            userName,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: RatingBarIndicator(
              itemSize: 20,
              unratedColor: Theme.of(context).primaryColor.withOpacity(0.3),
              itemCount: 5,
              rating: rating,
              itemBuilder: (context, index) {
                return Icon(
                  Icons.star,
                  color: AppTheme.primaryColor,
                );
              },
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              DateFormat('d MMMM y').format(
                date,
              ),
            ),
          ),
        ),
        Text(
          comment,
          style: Theme.of(context).textTheme.caption!,
        ),
        SizedBox(height: 35.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                width: 110.w,
                height: 36.h,
                color: AppTheme.borderColor.withOpacity(0.1),
                child: Center(
                  child: Text(
                    'Helpful',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Report',
              ),
            )
          ],
        ),
        SizedBox(height: 25.h),
        Divider(
          color: AppTheme.borderColor,
        ),
      ],
    );
  }
}
