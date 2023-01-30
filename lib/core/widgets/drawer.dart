import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wtech_ecommerce/core/routes/app_route.dart';
import 'package:wtech_ecommerce/core/theme/theme.dart';
import 'package:wtech_ecommerce/core/widgets/loading.dart';

import '../../features/authentication/presentation/bloc/authentication_bloc.dart';
import '../../features/cart/presentation/bloc/cart_bloc.dart';
import '../functions/snackbars.dart';
import 'package:wtech_ecommerce/services_locator.dart' as di;

import '../theme/app_icons.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listTileData = [
      {
        'title': 'Cart',
        'Icon': Icon(
          Icons.shopping_cart_outlined,
          color: AppTheme.captionColor,
        ),
        'onTap': () {
          context.pushNamed(cartScreen);
        },
      },
      {
        'title': 'Order History',
        'Icon': Icon(
          Icons.list_alt_outlined,
          color: AppTheme.captionColor,
        ),
        'onTap': () {
          context.pushNamed(orderHistory);
        },
      },
      {
        'title': 'My Addresses',
        'Icon': Icon(
          Icons.contact_mail_outlined,
          color: AppTheme.captionColor,
        ),
        'onTap': () {
          context.pushNamed(addressScreen);
        },
      },
      {
        'title': 'My Cards',
        'Icon': Icon(
          Icons.credit_card_outlined,
          color: AppTheme.captionColor,
        ),
        'onTap': () {
          context.pushNamed(creditCardsScreen);
        },
      },
      {
        'title': 'Vouchers',
        'Icon': Icon(
          Icons.redeem_outlined,
          color: AppTheme.captionColor,
        ),
        'onTap': () {
          showSnackBar(
            context: context,
            iconData: Icons.info,
            title: 'There is no any vouchers available',
            statusColor: AppTheme.borderColor,
          );
        },
      },
      {
        'title': 'Nearby Stores',
        'Icon': Icon(
          Icons.local_convenience_store_outlined,
          color: AppTheme.captionColor,
        ),
        'onTap': () {
          showSnackBar(
            context: context,
            iconData: Icons.info,
            title: 'Nearby store is under development',
            statusColor: AppTheme.borderColor,
          );
        },
      },
      {
        'title': 'Sign Out',
        'Icon': Icon(
          Icons.logout_outlined,
          color: AppTheme.captionColor,
        ),
        'onTap': () {
          context.read<AuthenticationBloc>().add(SignedOut());
        },
      },
    ];
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is UnAthenticatedState) {
          context.replaceNamed(signInScreen);
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return const Loading();
        }
        var userJson = di.preferences.getString('user');
        var user = jsonDecode(userJson!) as Map<String, dynamic>;
        return Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //* Drawer Header
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 130.h,
                  padding: const EdgeInsets.only(top: 50),
                  color: AppTheme.black,
                  child: ListTile(
                    leading: ClipOval(
                      child: user['profilePicture'] == null
                          ? Container(
                              width: 40.w,
                              height: 60.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.borderColor,
                              ),
                              child: Transform.scale(
                                scale: 0.5,
                                child: Image.asset(AppIcons.imageGrey),
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: user['profilePicture']!,
                              width: 40.w,
                            ),
                    ),
                    title: Text(
                      user['name'],
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                    subtitle: Text(
                      user['email'],
                      style: Theme.of(context)
                          .appBarTheme
                          .titleTextStyle!
                          .copyWith(
                              fontSize: 12.h, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                ...List.generate(
                  listTileData.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: listTileData[index]['onTap'],
                          hoverColor: AppTheme.borderColor,
                          contentPadding: EdgeInsets.zero,
                          leading: listTileData[index]['Icon'],
                          title: listTileData[index]['title'] == 'Cart'
                              ? Wrap(
                                  spacing: 10,
                                  children: [
                                    Text(
                                      listTileData[index]['title'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 16.sp,
                                          ),
                                    ),
                                    BlocBuilder<CartBloc, CartState>(
                                      builder: (context, state) {
                                        return state.cartItems.isNotEmpty
                                            ? Container(
                                                width: 25.w,
                                                height: 25.h,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppTheme.primaryColor,
                                                ),
                                                child: Text(
                                                  '${state.cartItems.length}',
                                                  style: Theme.of(context)
                                                      .appBarTheme
                                                      .titleTextStyle,
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            : const SizedBox();
                                      },
                                    ),
                                  ],
                                )
                              : Text(
                                  listTileData[index]['title'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 16.sp,
                                      ),
                                ),
                        ),
                        Divider(
                          color: AppTheme.borderColor,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
