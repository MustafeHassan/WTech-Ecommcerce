import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DashboardModel {
  final double totalSales;
  final int totalOrders;
  final int totalproducts;
  final Map<String, dynamic> statisticsSales;
  final List<Map<String, dynamic>> latestOrders;
  DashboardModel({
    required this.totalSales,
    required this.totalOrders,
    required this.totalproducts,
    required this.statisticsSales,
    required this.latestOrders,
  });

  factory DashboardModel.fromMap(Map<String, dynamic> map) {
    return DashboardModel(
      totalSales: map['totalSales'] as double,
      totalOrders: map['totalOrders'] as int,
      totalproducts: map['totalproducts'] as int,
      statisticsSales: map['statisticsSales'],
      latestOrders: map['latestOrders'],
    );
  }

  factory DashboardModel.fromJson(String source) =>
      DashboardModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
