import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:wtech_dashboard/core/errors/exceptions.dart';

import 'package:wtech_dashboard/features/dashboard/data/models/dashboard_model.dart';

class DashboardDataSource {
  final FirebaseFirestore firestore;
  DashboardDataSource({
    required this.firestore,
  });

  Future<DashboardModel> getDashboardData() async {
    try {
      var querySnapshotProducts = await firestore.collection('products').get();
      var querySnapshotOrders = await firestore.collection('orders').get();
      List<Map<String, dynamic>> latestOrders = [];

      double totalSales = 0;
      int totalProducts = querySnapshotProducts.docs.length;
      int totalOrders = querySnapshotOrders.docs.length;
      for (var order in querySnapshotOrders.docs) {
        latestOrders.add(order.data());
        if (order.data()['Delivered'] == true) {
          totalSales += order.data()['totalToPay'];
        }
      }
      Map<String, dynamic> dashboardMap = {
        'totalSales': totalSales,
        'totalOrders': totalOrders,
        'totalproducts': totalProducts,
        'statisticsSales': yearSales(
          querySnapshotOrders.docs
              .where((element) =>
                  DateTime.fromMillisecondsSinceEpoch(
                          element.data()['orderPlacedDate'])
                      .year ==
                  DateTime.now().year)
              .toList(),
        ),
        'latestOrders': latestOrders,
      };
      return DashboardModel.fromMap(dashboardMap);
    } catch (error) {
      debugPrint("EXCEPTION: $error");
      throw UnexpectedErrorException();
    }
  }

  Map<String, dynamic> yearSales(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> querySnapshotOrders,
  ) {
    num janSale = 0;
    num febSale = 0;
    num marSale = 0;
    num aprSale = 0;
    num maySale = 0;
    num junSale = 0;
    num julSale = 0;
    num augSale = 0;
    num sepSale = 0;
    num octSale = 0;
    num novSale = 0;
    num decSale = 0;

    var januarySales = querySnapshotOrders
        .where(
          (element) =>
              DateTime.fromMillisecondsSinceEpoch(
                      element.data()['orderPlacedDate'])
                  .month ==
              1,
        )
        .toList();
    for (var element in januarySales) {
      janSale += element.data()['totalToPay'];
    }
    //--------------------------------------------------------
    var febSales = querySnapshotOrders
        .where(
          (element) =>
              DateTime.fromMillisecondsSinceEpoch(
                      element.data()['orderPlacedDate'])
                  .month ==
              2,
        )
        .toList();
    for (var element in febSales) {
      febSale += element.data()['totalToPay'];
    }
    //--------------------------------------------------------
    var marSales = querySnapshotOrders
        .where(
          (element) =>
              DateTime.fromMillisecondsSinceEpoch(
                      element.data()['orderPlacedDate'])
                  .month ==
              3,
        )
        .toList();
    for (var element in marSales) {
      marSales += element.data()['totalToPay'];
    }
    //--------------------------------------------------------
    var aprSales = querySnapshotOrders
        .where(
          (element) =>
              DateTime.fromMillisecondsSinceEpoch(
                      element.data()['orderPlacedDate'])
                  .month ==
              4,
        )
        .toList();
    for (var element in aprSales) {
      aprSale += element.data()['totalToPay'];
    }
    //--------------------------------------------------------
    var maySales = querySnapshotOrders
        .where(
          (element) =>
              DateTime.fromMillisecondsSinceEpoch(
                      element.data()['orderPlacedDate'])
                  .month ==
              5,
        )
        .toList();
    for (var element in maySales) {
      maySale += element.data()['totalToPay'];
    }
    //--------------------------------------------------------
    var junSales = querySnapshotOrders
        .where(
          (element) =>
              DateTime.fromMillisecondsSinceEpoch(
                      element.data()['orderPlacedDate'])
                  .month ==
              6,
        )
        .toList();
    for (var element in junSales) {
      junSale += element.data()['totalToPay'];
    }

    //--------------------------------------------------------
    var julSales = querySnapshotOrders
        .where(
          (element) =>
              DateTime.fromMillisecondsSinceEpoch(
                      element.data()['orderPlacedDate'])
                  .month ==
              7,
        )
        .toList();
    for (var element in julSales) {
      julSale += element.data()['totalToPay'];
    }
    //--------------------------------------------------------
    var augSales = querySnapshotOrders
        .where(
          (element) =>
              DateTime.fromMillisecondsSinceEpoch(
                      element.data()['orderPlacedDate'])
                  .month ==
              8,
        )
        .toList();
    for (var element in augSales) {
      augSale += element.data()['totalToPay'];
    }
    //--------------------------------------------------------
    var sepSales = querySnapshotOrders
        .where(
          (element) =>
              DateTime.fromMillisecondsSinceEpoch(
                      element.data()['orderPlacedDate'])
                  .month ==
              9,
        )
        .toList();
    for (var element in sepSales) {
      sepSale += element.data()['totalToPay'];
    }
    //--------------------------------------------------------
    var octSales = querySnapshotOrders
        .where(
          (element) =>
              DateTime.fromMillisecondsSinceEpoch(
                      element.data()['orderPlacedDate'])
                  .month ==
              10,
        )
        .toList();
    for (var element in octSales) {
      octSale += element.data()['totalToPay'];
    }
    //--------------------------------------------------------
    var novSales = querySnapshotOrders
        .where(
          (element) =>
              DateTime.fromMillisecondsSinceEpoch(
                      element.data()['orderPlacedDate'])
                  .month ==
              11,
        )
        .toList();
    for (var element in novSales) {
      novSale += element.data()['totalToPay'];
    }
    //--------------------------------------------------------
    var decSales = querySnapshotOrders
        .where(
          (element) =>
              DateTime.fromMillisecondsSinceEpoch(
                      element.data()['orderPlacedDate'])
                  .month ==
              12,
        )
        .toList();
    for (var element in decSales) {
      decSale += element.data()['totalToPay'];
    }
    return {
      'jan': janSale,
      'feb': febSale,
      'mar': marSale,
      'apr': aprSale,
      'may': maySale,
      'jun': junSale,
      'jul': julSale,
      'aug': augSale,
      'sep': sepSale,
      'oct': octSale,
      'nov': novSale,
      'dec': decSale,
    };
  }
}
