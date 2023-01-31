import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class DashboardCardsMobile extends StatelessWidget {
  const DashboardCardsMobile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.iconData,
  }) : super(key: key);
  final String title, subtitle;
  final Color color;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.2),
                radius: 45,
              ),
              Positioned(
                top: 10,
                left: 10,
                child: CircleAvatar(
                  backgroundColor: color,
                  radius: 35,
                  child: Icon(
                    iconData,
                    color: AppColor.white,
                    size: 35,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: AppColor.captionColor.withOpacity(0.5),
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: 20,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
