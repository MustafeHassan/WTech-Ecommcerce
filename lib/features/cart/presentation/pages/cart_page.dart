import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wtech_ecommerce/features/cart/domain/entities/cart_entity.dart';

import 'package:wtech_ecommerce/features/cart/presentation/widgets/empty_cart.dart';

// import '../../../../core/functions/snackbars.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/scaffold_body.dart';
import '../../../store/presentation/widgets/icon_box.dart';
import '../bloc/cart_bloc.dart';
import '../widgets/cart_black.dart';
import '../widgets/cart_grey.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final ValueNotifier<bool> _isRemoveEnabled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.cartItems.isNotEmpty) {
          var items = state.cartItems;
          List<CartItem> itemsToOrder = [];
          for (var i = 0; i < items.length; i++) {
            itemsToOrder.add(items[i]);
          }
          return Scaffold(
            backgroundColor: AppTheme.black,
            appBar: AppBar(
              title: const Text(
                'CART',
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    _isRemoveEnabled.value = !_isRemoveEnabled.value;
                  },
                  icon: Icon(
                    CupertinoIcons.trash,
                    color: AppTheme.white,
                  ),
                ),
                SizedBox(width: 10.w),
              ],
            ),
            body: ScaffoldBody(
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isRemoveEnabled,
                    builder: (context, value, child) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            items[index];
                            if (index % 2 == 0) {
                              return Column(
                                children: [
                                  Stack(
                                    children: [
                                      BlackCartCard(
                                        canQuantityDescrease:
                                            items[index].quantity == 1,
                                        quantity: items[index].quantity,
                                        increase: () {
                                          setState(() {
                                            items[index].quantity++;
                                          });
                                        },
                                        descrease: () {
                                          setState(() {
                                            items[index].quantity--;
                                          });
                                        },
                                        imageUrl: items[index].imageUrl,
                                        name: items[index].name,
                                        price: items[index].price *
                                            items[index].quantity,
                                        productColor:
                                            items[index].color ?? 'N/A',
                                      ),
                                      Visibility(
                                        visible: value,
                                        child: Positioned(
                                          top: 10,
                                          right: 10,
                                          child: IconBox(
                                            onTap: () {
                                              context.read<CartBloc>().add(
                                                    ProductOfCartRemoved(
                                                      item: items[index],
                                                    ),
                                                  );
                                            },
                                            boxColor: AppTheme.red,
                                            iconPath: AppIcons.trash,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  Stack(
                                    children: [
                                      GreyCardCard(
                                        canQuantityDescrease:
                                            items[index].quantity == 1,
                                        quantity: items[index].quantity,
                                        increase: () {
                                          setState(() {
                                            items[index].quantity++;
                                          });
                                        },
                                        descrease: () {
                                          setState(() {
                                            items[index].quantity--;
                                          });
                                        },
                                        imageUrl: items[index].imageUrl,
                                        name: items[index].name,
                                        price: items[index].price *
                                            items[index].quantity,
                                        productColor:
                                            items[index].color ?? 'N/A',
                                      ),
                                      Visibility(
                                        visible: value,
                                        child: Positioned(
                                          top: 10,
                                          right: 10,
                                          child: IconBox(
                                            onTap: () {
                                              context.read<CartBloc>().add(
                                                    ProductOfCartRemoved(
                                                      item: items[index],
                                                    ),
                                                  );
                                            },
                                            boxColor: AppTheme.red,
                                            iconPath: AppIcons.trash,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                ],
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('TOTAL',
                          style: Theme.of(context).textTheme.bodyText1),
                      Text(
                        items.isEmpty
                            ? '0.0'
                            : '\$${items.map<double>((cart) => cart.price * cart.quantity).reduce((value, element) => value + element).toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  ElevatedButton(
                    onPressed: () {
                      var subTotal = items
                          .map<double>((cart) => cart.price * cart.quantity)
                          .reduce((value, element) => value + element)
                          .floorToDouble();
                      context.pushNamed(
                        orderDetailScreen,
                        extra: [subTotal, itemsToOrder],
                      );
                    },
                    child: Text('ORDER NOW',
                        style: Theme.of(context).textTheme.button),
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          );
        } else {
          return const EmptyCart();
        }
      },
    );
  }
}
