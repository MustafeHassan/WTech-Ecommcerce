import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import 'side_menu.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
            child: Row(
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
          ),
          const Divider(),
          const Expanded(child: SideMenu()),
        ],
      ),
    );
  }
}
