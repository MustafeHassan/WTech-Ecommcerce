// ignore_for_file: unnecessary_string_escapes

import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wtech_ecommerce/core/widgets/loading.dart';
import 'package:wtech_ecommerce/features/order/presentation/bloc/credit_cards/credit_cards_bloc.dart';
import 'package:wtech_ecommerce/features/order/presentation/bloc/shipping_address/shipping_address_bloc.dart';

import '../../../../core/functions/snackbars.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/scaffold_body.dart';
import '../../../cart/domain/entities/cart_entity.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../bloc/order/order_bloc.dart';
import 'package:wtech_ecommerce/services_locator.dart' as di;

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  final List<dynamic> order;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final ValueNotifier<String> _shippingMethod =
      ValueNotifier('Standard Shipping (16 days)');
  final ValueNotifier<int> _shippingPrice = ValueNotifier(0);
  final ValueNotifier<double> _totalToPay = ValueNotifier(0);
  @override
  void initState() {
    super.initState();
    context.read<CreditCardsBloc>().add(AllCreditCardsRequested());
    context.read<ShippingAddressBloc>().add(AllShippingAddressRequested());
  }

  String orderId = '';
  Map<String, dynamic> _shippingAddress = {};
  Map<String, dynamic> _paymentMethod = {};
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderErrorState) {
          showSnackBar(
            context: context,
            iconData: Icons.error,
            title: state.error,
            statusColor: AppTheme.red,
          );
        } else if (state is OrderPlaceSuccess) {
          for (var i = 0; i < widget.order.last.length; i++) {
            BlocProvider.of<CartBloc>(context).add(
              ProductOfCartRemoved(
                item: (widget.order[1][i] as CartItem),
              ),
            );
          }
          context.pop();
          context.replaceNamed(orderPlaceSuccessScreen,
              params: {'orderId': orderId});
        }
      },
      builder: (context, state) {
        if (state is OrderLoadingState) {
          return const Loading();
        }
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Icons.keyboard_backspace,
                color: AppTheme.white,
              ),
            ),
            title: const Text(
              'ORDER DETAIL',
            ),
          ),
          body: ScaffoldBody(
            removePadding: true,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('SHIPPING TO',
                                style: Theme.of(context).textTheme.caption),
                            TextButton(
                              onPressed: () {
                                context.pushNamed(
                                  shippingAddressScreen,
                                );
                              },
                              child: const Text('Change'),
                            ),
                          ],
                        ),
                        BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
                          builder: (context, state) {
                            if (state is AllShippingAddressReceivedState) {
                              _shippingAddress = {
                                ...{
                                  'contactName': state.address.contactName,
                                  'email': state.address.email,
                                  'phoneNumber': state.address.phoneNumber,
                                  'addressLine1': state.address.addressLine1,
                                  'addressLine2': state.address.addressLine2,
                                  'country': state.address.country,
                                  'city': state.address.city,
                                  'zipCode': state.address.zipCode,
                                  'isDefault': state.address.isDefault,
                                }
                              };
                              return Text(
                                '${state.address.addressLine1}\n${state.address.zipCode} - ${state.address.country}',
                                style: Theme.of(context).textTheme.bodyText1,
                              );
                            }
                            if (jsonDecode(di.preferences.getString('user')!)[
                                    'address'] ==
                                null) {
                              return Text(
                                'No Shipping Address Found',
                                style: Theme.of(context).textTheme.bodyText1,
                              );
                            } else {
                              var user =
                                  jsonDecode(di.preferences.getString('user')!);
                              return Text(
                                  '${user['address']['address line 1']},\n${user['address']['zipCode']} - ${user['address']['city']}/${user['address']['country']}',
                                  style: Theme.of(context).textTheme.bodyText1);
                            }
                          },
                        ),
                        //****************** */
                        SizedBox(height: 12.h),
                        const Divider(),
                        SizedBox(height: 15.h),
                        //****************** */

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('PAY WITH CREDIT CARD',
                                style: Theme.of(context).textTheme.caption),
                            TextButton(
                              onPressed: () {
                                context.pushNamed(paymentDetailScreen);
                              },
                              child: const Text('Change'),
                            ),
                          ],
                        ),
                        BlocBuilder<CreditCardsBloc, CreditCardsState>(
                          builder: (context, state) {
                            if (state is AllCreditCardsReceivedState) {
                              _paymentMethod = {
                                ...{
                                  'cardHolder': state.card.cardHolder,
                                  'cardNumber': state.card.cardNumber,
                                  'cardExpireDate': state.card.cardExpireDate,
                                  'cvc': state.card.cvc,
                                  'isDefault': state.card.isDefault,
                                }
                              };
                              return Text(
                                'XXXX - XXXX - XXXX - ${state.card.cardNumber.substring(12)}',
                                style: Theme.of(context).textTheme.bodyText1,
                              );
                            }
                            return Text(
                              'No Credit Card Found',
                              style: Theme.of(context).textTheme.bodyText1,
                            );
                          },
                        ),
                        //****************** */
                        SizedBox(height: 12.h),
                        const Divider(),
                        SizedBox(height: 15.h),
                        //****************** */

                        Text('ORDER DETAIL',
                            style: Theme.of(context).textTheme.caption),
                        const Divider(),
                        SizedBox(height: 15.h),
                        SizedBox(
                          height: 200.h,
                          child: ListView.builder(
                            itemCount: widget.order[1].length,
                            itemBuilder: (context, index) {
                              var items = (widget.order[1][index] as CartItem);
                              return ListTile(
                                leading: CachedNetworkImage(
                                  imageUrl: items.imageUrl,
                                  width: 90.w,
                                  height: 90.h,
                                ),
                                title: Text(items.name,
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                subtitle: Text('\$${items.price}',
                                    style:
                                        Theme.of(context).textTheme.headline4),
                                contentPadding: EdgeInsets.zero,
                              );
                            },
                          ),
                        ),
                        //****************** */

                        const Divider(),
                        SizedBox(height: 15.h),
                        //****************** */

                        Text('SHIPPING METHOD',
                            style: Theme.of(context).textTheme.caption),
                        SizedBox(height: 10.h),
                        ValueListenableBuilder<String>(
                          valueListenable: _shippingMethod,
                          builder: (context, value, child) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile(
                                        contentPadding: EdgeInsets.zero,
                                        value: 'Standard Shipping (16 days)',
                                        title: Text(
                                          'Standard Shipping (16 days)',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        groupValue: value,
                                        onChanged: (String? selected) {
                                          _shippingMethod.value = selected!;
                                          _shippingPrice.value = 0;
                                          _totalToPay.value =
                                              _shippingPrice.value +
                                                  (widget.order[0] as double);
                                        },
                                      ),
                                    ),
                                    Text(
                                      'FREE',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: AppTheme.primaryColor,
                                          ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile(
                                        contentPadding: EdgeInsets.zero,
                                        value: 'Express (8 days)',
                                        title: Text(
                                          'Express (8 days)',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        groupValue: value,
                                        onChanged: (String? selected) {
                                          _shippingMethod.value = selected!;
                                          _shippingPrice.value = 40;
                                          _totalToPay.value =
                                              _shippingPrice.value +
                                                  (widget.order[0] as double);
                                        },
                                      ),
                                    ),
                                    Text('\$40',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile(
                                        contentPadding: EdgeInsets.zero,
                                        value: 'Premium (1 day)',
                                        title: Text(
                                          'Premium (1 day)',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        groupValue: value,
                                        onChanged: (String? selected) {
                                          _shippingMethod.value = selected!;
                                          _shippingPrice.value = 80;
                                          _totalToPay.value =
                                              _shippingPrice.value +
                                                  (widget.order[0] as double);
                                        },
                                      ),
                                    ),
                                    Text('\$80',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r)),
                      color: AppTheme.black,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'SUBTOTAL',
                              style:
                                  Theme.of(context).appBarTheme.titleTextStyle,
                            ),
                            Text(
                              '\$${(widget.order[0] as double)}',
                              style: Theme.of(context)
                                  .appBarTheme
                                  .titleTextStyle!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'SHIPPING',
                              style:
                                  Theme.of(context).appBarTheme.titleTextStyle,
                            ),
                            ValueListenableBuilder(
                              valueListenable: _shippingPrice,
                              builder: (BuildContext context, int value,
                                  Widget? child) {
                                return Text(
                                  value == 0 ? 'FREE' : '\$$value',
                                  style: Theme.of(context)
                                      .appBarTheme
                                      .titleTextStyle!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 35.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total to Pay',
                              style: Theme.of(context)
                                  .appBarTheme
                                  .titleTextStyle!
                                  .copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: _totalToPay,
                              builder: (BuildContext context, double value,
                                  Widget? child) {
                                return Text(
                                  value == 0
                                      ? '\$${(widget.order[0] as double)}'
                                      : '\$$value',
                                  style: Theme.of(context)
                                      .appBarTheme
                                      .titleTextStyle!
                                      .copyWith(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 35.h),
                        ElevatedButton(
                          onPressed: () {
                            orderId = '#${Random().nextInt(100000)}';
                            context.read<OrderBloc>().add(
                                  OrderPlaced(
                                    orderId: orderId,
                                    orderPlacedDate: DateTime.now(),
                                    orderStatus: const {
                                      'Order Placed': true,
                                      'Proccessing': false,
                                      'Picked up by the courier': false,
                                      'Delivering': false,
                                      'Delivered': false,
                                    },
                                    shippingAddress: _shippingAddress,
                                    paymentCard: _paymentMethod,
                                    shippingMethod: _shippingMethod.value,
                                    totalToPay: _totalToPay.value == 0
                                        ? (widget.order[0] as double)
                                        : _totalToPay.value,
                                  ),
                                );
                          },
                          child: Text('PLACE ORDER',
                              style: Theme.of(context).textTheme.button),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
