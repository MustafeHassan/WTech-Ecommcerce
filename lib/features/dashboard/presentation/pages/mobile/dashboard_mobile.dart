import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wtech_dashboard/core/functions/snackbars.dart';

import 'package:wtech_dashboard/core/theme/colors.dart';
import 'package:wtech_dashboard/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:wtech_dashboard/features/dashboard/presentation/widgets/dashboard_card_mobile.dart';

import '../../widgets/chart_column.dart';
import '../../widgets/circle_chart.dart';
import '../../widgets/orders_table.dart';

class DashboardPageMobile extends StatefulWidget {
  const DashboardPageMobile({super.key});
  static final List<ChartData> _chartData = [
    ChartData(
      color: AppColor.primaryColor,
      title: 'Social Media',
      percentage: 60,
    ),
    ChartData(
      color: AppColor.red,
      title: 'Affilate Visitors',
      percentage: 20,
    ),
    ChartData(
      color: AppColor.captionColor,
      title: 'Purchased Visitors',
      percentage: 10,
    ),
    ChartData(
      color: AppColor.green,
      title: 'By Advertisment',
      percentage: 14,
    ),
  ];

  @override
  State<DashboardPageMobile> createState() => _DashboardPageMobileState();
}

class _DashboardPageMobileState extends State<DashboardPageMobile> {
  final List<ChartColumnData> _chartDataColumn = [];
  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().getDashboardDataCubit();
  }

  Widget salesStatistics(Map<String, dynamic> salesDate) {
    for (var sale in salesDate.entries) {
      _chartDataColumn.add(
        ChartColumnData(monthX: sale.key.toUpperCase(), totalY: sale.value),
      );
    }
    return ChartColumn(
      chartDataColumn: _chartDataColumn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: Theme.of(context).textTheme.headline2,
            ),
            BlocConsumer<DashboardCubit, DashboardState>(
              listener: (context, state) {
                if (state is DashboardDataError) {
                  showSnackBar(
                    context: context,
                    iconData: Icons.error,
                    title: state.error,
                    statusColor: Colors.red,
                  );
                }
              },
              builder: (context, state) {
                if (state is DashboardDataRecieved) {
                  return Column(
                    children: [
                      DashboardCardsMobile(
                        title: 'Total Sales',
                        color: AppColor.orange,
                        iconData: Icons.attach_money,
                        subtitle: '\$${state.dashboard.totalSales}',
                      ),
                      DashboardCardsMobile(
                        title: 'Total Orders',
                        color: AppColor.green,
                        iconData: Icons.shopping_cart,
                        subtitle: '${state.dashboard.totalOrders}',
                      ),
                      DashboardCardsMobile(
                        title: 'Total Products',
                        color: AppColor.primaryColor,
                        iconData: Icons.shopping_basket,
                        subtitle: '${state.dashboard.totalproducts}',
                      ),
                      salesStatistics(state.dashboard.statisticsSales),
                    ],
                  );
                }
                return Column(
                  children: [
                    DashboardCardsMobile(
                      title: 'Total Sales',
                      color: AppColor.orange,
                      iconData: Icons.attach_money,
                      subtitle: '\$0',
                    ),
                    DashboardCardsMobile(
                      title: 'Total Orders',
                      color: AppColor.green,
                      iconData: Icons.shopping_cart,
                      subtitle: '0',
                    ),
                    DashboardCardsMobile(
                      title: 'Total Products',
                      color: AppColor.primaryColor,
                      iconData: Icons.shopping_basket,
                      subtitle: '0',
                    ),
                    ChartColumn(chartDataColumn: _chartDataColumn),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            CircleChart(chartData: DashboardPageMobile._chartData),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              color: AppColor.white,
              height: 400,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Latest Orders',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 25),
                    OrdersData(
                      color: AppColor.green,
                      customerEmail: 'mustafe3332@gmail.com',
                      customerName: 'Mustafe Hassan',
                      orderDate: '21.10.2022',
                      orderId: '#21211',
                      orderStatus: 'Delivered',
                      totalPrice: 123.22,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
