import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wtech_ecommerce/core/theme/theme.dart';
import 'package:wtech_ecommerce/core/widgets/loading.dart';
import 'package:wtech_ecommerce/core/widgets/scaffold_body.dart';
import 'package:wtech_ecommerce/features/order/presentation/bloc/order/order_bloc.dart';

import '../../../../core/routes/app_route.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(AllOrdersRequisted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ORDER HISTORY',
        ),
      ),
      body: ScaffoldBody(
        child: BlocConsumer<OrderBloc, OrderState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is OrderLoadingState) {
              return const Loading();
            }
            if (state is OrdersReceivedState) {
              if (state.orders.isNotEmpty) {
                return Column(
                  children: [
                    SizedBox(height: 30.h),
                    Expanded(
                      child: ListView.separated(
                        itemCount: state.orders.length,
                        separatorBuilder: (BuildContext context, int index) {
                          var order = state.orders[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ORDER  ${order.orderId}',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  SizedBox(height: 20.h),
                                  Text(
                                      'Place on:  ${DateFormat('dd of MMMM').format(order.orderPlacedDate)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  Text('Amount:   \$${order.totalToPay}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  Text(
                                      'Status:     ${order.orderStatus.entries.lastWhere((element) => element.value).key}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  context.pushNamed(orderHistoryDetail,
                                      extra: order);
                                },
                                child: const Text(
                                  'View Details',
                                ),
                              )
                            ],
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return const SizedBox();
                          } else {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Divider(
                                color: AppTheme.captionColor,
                              ),
                            );
                          }
                        },
                      ),
                    )
                  ],
                );
              } else {
                return Center(
                  child: Text('No Orders Found or something went wrong !',
                      style: Theme.of(context).textTheme.headline4),
                );
              }
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
