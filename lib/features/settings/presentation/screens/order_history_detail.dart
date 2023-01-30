// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/scaffold_body.dart';
import '../../../order/domain/entities/order_entity.dart';
import '../../../order/presentation/widgets/order_status.dart';

class OrderHistoryDetail extends StatelessWidget {
  const OrderHistoryDetail({
    Key? key,
    required this.orderDetail,
  }) : super(key: key);
  final OrderE orderDetail;

  @override
  Widget build(BuildContext context) {
    var orderStatus = orderDetail.orderStatus;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ORDER STATUS',
        ),
      ),
      body: ScaffoldBody(
        removePadding: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                ...List.generate(
                  5,
                  (index) => OrderStatus(
                    orderId: orderDetail.orderId,
                    orderPlacedDate: DateFormat('dd MMMM yyyy')
                        .format(orderDetail.orderPlacedDate),
                    isLastLine: index == 4 ? true : false,
                    statusComplete:
                        orderStatus.values.toList().reversed.toList()[index],
                    title: orderStatus.keys.toList().reversed.toList()[index],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
