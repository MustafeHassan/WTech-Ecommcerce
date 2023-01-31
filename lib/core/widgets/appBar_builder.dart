// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:wtech_dashboard/responsiveness.dart';

import '../../../../core/theme/colors.dart';

PreferredSizeWidget topBar(BuildContext context,
    [GlobalKey<ScaffoldState>? key]) {
  return AppBar(
    leading: !Responsiveness.isDesktop(context)
        ? IconButton(
            onPressed: () {
              key?.currentState?.openDrawer();
            },
            icon: const Icon(Icons.menu),
          )
        : Row(
            children: [
              Image.asset(
                filterQuality: FilterQuality.medium,
                'assets/images/logo.png',
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 5),
              Text(
                'WTech',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
    leadingWidth: !Responsiveness.isDesktop(context) ? 56 : 160,
    title: TextFormField(
      decoration: const InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(Icons.search),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    ),
    actions: [
      Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.sunny,
              color: AppColor.captionColor.withOpacity(0.5),
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  color: AppColor.captionColor.withOpacity(0.5),
                ),
              ),
              Positioned(
                top: 10,
                right: 13,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(
        width: 20,
      ),
      const CircleAvatar(
        child: Icon(Icons.person),
      ),
      const SizedBox(
        width: 20,
      )
    ],
    backgroundColor: AppColor.white,
    elevation: 1.2,
  );
}
