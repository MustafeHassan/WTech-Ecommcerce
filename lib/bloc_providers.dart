// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wtech_ecommerce/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:wtech_ecommerce/features/order/presentation/bloc/credit_cards/credit_cards_bloc.dart';
import 'package:wtech_ecommerce/features/order/presentation/bloc/shipping_address/shipping_address_bloc.dart';
import 'package:wtech_ecommerce/features/settings/presentation/cubit/profile_picture_cubit.dart';
import 'package:wtech_ecommerce/services_locator.dart' as di;

import 'features/authentication/presentation/bloc/authentication_bloc.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/order/presentation/bloc/order/order_bloc.dart';
import 'features/store/presentation/bloc/brands/brands_bloc.dart';
import 'features/store/presentation/bloc/category/category_bloc.dart';
import 'features/store/presentation/bloc/products/products_bloc.dart';

Widget blocProviders(Widget child) {
  return MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        create: (context) => di.sl<AuthenticationBloc>(),
      ),
      BlocProvider<CategoryBloc>(
        create: (context) => di.sl<CategoryBloc>(),
      ),
      BlocProvider<ProductsBloc>(
        create: (context) => di.sl<ProductsBloc>(),
      ),
      BlocProvider<BrandsBloc>(
        create: (context) => di.sl<BrandsBloc>(),
      ),
      BlocProvider<CartBloc>(
        create: (context) => di.sl<CartBloc>(),
      ),
      BlocProvider<FavoritesBloc>(
        create: (context) => di.sl<FavoritesBloc>(),
      ),
      BlocProvider<OrderBloc>(
        create: (context) => di.sl<OrderBloc>(),
      ),
      BlocProvider<ShippingAddressBloc>(
        create: (context) => di.sl<ShippingAddressBloc>(),
      ),
      BlocProvider<CreditCardsBloc>(
        create: (context) => di.sl<CreditCardsBloc>(),
      ),
      BlocProvider<ProfilePictureCubit>(
        create: (context) => di.sl<ProfilePictureCubit>(),
      ),
    ],
    child: child,
  );
}
