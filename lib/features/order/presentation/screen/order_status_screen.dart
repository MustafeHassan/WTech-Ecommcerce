import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:wtech_ecommerce/core/widgets/loading.dart';

import '../../../../core/widgets/scaffold_body.dart';
import '../bloc/order/order_bloc.dart';
import '../widgets/order_status.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({Key? key, this.isFromHistory = false})
      : super(key: key);
  final bool isFromHistory;

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.isFromHistory == false) {
      context.read<OrderBloc>().add(AllOrdersRequisted());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ORDER STATUS',
        ),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoadingState) {
            return const Loading();
          }
          if (state is OrdersReceivedState) {
            var orderStatus = state.orders.last.orderStatus;
            return ScaffoldBody(
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
                          orderId: state.orders.last.orderId,
                          orderPlacedDate: DateFormat('dd MMMM yyyy')
                              .format(state.orders.last.orderPlacedDate),
                          isLastLine: index == 4 ? true : false,
                          statusComplete: orderStatus.values
                              .toList()
                              .reversed
                              .toList()[index],
                          title: orderStatus.keys
                              .toList()
                              .reversed
                              .toList()[index],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
