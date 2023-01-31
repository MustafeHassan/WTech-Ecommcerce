import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wtech_dashboard/core/routes/app_routes.dart';

import 'side_menu_list_tile.dart';
import 'side_menu_list_tile_with_expantion.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});
  static final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  static final List<Map<String, dynamic>> _listTiles = [
    {
      'Title': 'Dashboard',
      'Icon': Icons.dashboard,
      'onTap': (BuildContext context) {
        context.goNamed(dashboardScreen);
      }
    },
    {
      'Title': 'Products',
      'Icon': Icons.chair_rounded,
      'onTap': (BuildContext context) {
        context.goNamed(productsScreen);
      },
      'Children': [
        'Add project',
        'Product list',
        'Categories',
        'Brands',
      ],
    },
    {
      'Title': 'Orders',
      'Icon': Icons.shopping_cart,
      'onTap': (BuildContext context) {
        context.goNamed(ordersScreen);
      }
    },
    {
      'Title': 'Customers',
      'Icon': Icons.people_alt_sharp,
      'onTap': (BuildContext context) {
        context.goNamed(customersScreen);
      }
    },
    {
      'Title': 'Statistics',
      'Icon': Icons.bar_chart_rounded,
      'onTap': (BuildContext context) {
        context.goNamed(statisticsScreen);
      }
    },
    {
      'Title': 'Reviews',
      'Icon': Icons.reviews,
      'onTap': (BuildContext context) {
        context.goNamed(reviewsScreen);
      }
    },
    {
      'Title': 'Transactions',
      'Icon': Icons.credit_score,
      'onTap': (BuildContext context) {
        context.goNamed(transactionsScreen);
      }
    },
    {
      'Title': 'Sellers',
      'Icon': Icons.sell,
      'onTap': (BuildContext context) {
        context.goNamed(sellersScreen);
      }
    },
    {
      'Title': 'Settings',
      'Icon': Icons.settings,
      'onTap': (BuildContext context) {
        context.goNamed(settingsScreen);
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _selectedIndex,
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: _listTiles.length,
          itemBuilder: (BuildContext context, int index) {
            if ((_listTiles[index]['Title'] == 'Products')) {
              return SideMenuListTileWithExpantion(
                texts: _listTiles[index]['Children'],
                icon: _listTiles[index]['Icon'],
                title: _listTiles[index]['Title'],
                isSelected: index == value,
                onTap: () {
                  _selectedIndex.value = index;
                  _listTiles[index]['onTap'](context);
                },
              );
            } else {
              return SideMenuListTile(
                icon: _listTiles[index]['Icon'],
                title: _listTiles[index]['Title'],
                isSelected: index == value,
                onTap: () {
                  _selectedIndex.value = index;
                  Scaffold.of(context).closeEndDrawer();
                  _listTiles[index]['onTap'](context);
                },
              );
            }
          },
        );
      },
    );
  }
}
