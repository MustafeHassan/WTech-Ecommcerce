import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/theme.dart';
import '../../bloc/pages/pages_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.pageIndex,
  }) : super(key: key);

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0.0,
      backgroundColor: AppTheme.white,
      enableFeedback: true,
      onTap: (value) => context.read<PagesCubit>().changePageIndex(value),
      currentIndex: pageIndex,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppIcons.home,
            width: 25..w,
            height: 25..h,
          ),
          tooltip: 'Home',
          label: '',
          activeIcon: SvgPicture.asset(
            AppIcons.homeblue,
            width: 25..w,
            height: 25..h,
          ),
          // activeIcon: Icon(Icons.r_mobiledata)
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppIcons.categorey,
            width: 25..w,
            height: 25..h,
          ),
          tooltip: 'Categories',
          label: '',
          activeIcon: SvgPicture.asset(
            AppIcons.categoreyblue,
            width: 25..w,
            height: 25..h,
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppIcons.bookmarkOutlined,
            width: 25..w,
            height: 25..h,
          ),
          tooltip: 'Favorites',
          label: '',
          activeIcon: SvgPicture.asset(
            AppIcons.bookmarkblueOutlined,
            width: 25..w,
            height: 25..h,
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppIcons.settings,
            width: 25..w,
            height: 25..h,
          ),
          tooltip: 'Settings',
          label: '',
          activeIcon: SvgPicture.asset(
            AppIcons.settingsblue,
            width: 25..w,
            height: 25..h,
          ),
        ),
      ],
    );
  }
}
