// ignore_for_file: unused_element

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:wtech_ecommerce/core/routes/app_route.dart';
import 'package:wtech_ecommerce/core/routes/error_page.dart';
import 'package:wtech_ecommerce/features/authentication/presentation/screens/email_sent.screen.dart';
import 'package:wtech_ecommerce/features/authentication/presentation/screens/forgot_password_screen.dart';
import 'package:wtech_ecommerce/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:wtech_ecommerce/features/cart/presentation/pages/cart_page.dart';
import 'package:wtech_ecommerce/features/cart/presentation/widgets/empty_cart.dart';
import 'package:wtech_ecommerce/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:wtech_ecommerce/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:wtech_ecommerce/features/order/domain/entities/order_entity.dart';
import 'package:wtech_ecommerce/features/order/presentation/screen/order_place_success_screen.dart';
import 'package:wtech_ecommerce/features/settings/presentation/screens/addresss_screen.dart';
import 'package:wtech_ecommerce/features/settings/presentation/screens/credit_cards_screen.dart';
import 'package:wtech_ecommerce/features/settings/presentation/screens/new_update_address_screen.dart';
import 'package:wtech_ecommerce/features/settings/presentation/screens/order_history.dart';
import 'package:wtech_ecommerce/features/settings/presentation/screens/order_history_detail.dart';
import 'package:wtech_ecommerce/features/store/domain/entities/products_entity.dart';
import 'package:wtech_ecommerce/features/store/presentation/screens/all_brands.dart';
import 'package:wtech_ecommerce/features/store/presentation/screens/all_products_screen.dart';
import 'package:wtech_ecommerce/features/store/presentation/screens/filter_sort_screen.dart';
import 'package:wtech_ecommerce/features/store/presentation/screens/product_detail_screen.dart';
import 'package:wtech_ecommerce/features/store/presentation/screens/products_of_category_screen.dart';
import 'package:wtech_ecommerce/features/store/presentation/screens/products_of_brands_screen.dart';
import 'package:wtech_ecommerce/features/store/presentation/screens/store_screen.dart';
import '../../features/authentication/presentation/screens/sign_up_screen.dart';
import '../../features/favorites/presentation/pages/favorites_page.dart';
import '../../features/order/presentation/screen/order_detail_screen.dart';
import '../../features/order/presentation/screen/order_status_screen.dart';
import '../../features/order/presentation/screen/payment_detail_screen.dart';
import '../../features/order/presentation/screen/shipping_address_screen.dart';
import '../../features/store/domain/entities/category_entity.dart';
import '../../features/store/presentation/screens/search_products_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter _router = GoRouter(
    initialLocation: root,
    urlPathStrategy: UrlPathStrategy.path,
    errorBuilder: (context, state) {
      if (kDebugMode) {
        print(state.error);
      }
      return const PageNotFound();
    },
    routes: [
      GoRoute(
        path: '/',
        name: root,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/onboarding',
        name: introductionScreen,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: '/sign-in',
        name: signInScreen,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const SignInScreen(),
        ),
      ),
      GoRoute(
        path: '/sign-up',
        name: signUpScreen,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const SignUpScreen(),
        ),
      ),
      GoRoute(
        path: '/email-sent',
        name: emailSentScreen,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const EmailSentScreen(),
        ),
      ),
      GoRoute(
        path: '/forgot-password',
        name: forgotPasswordScreen,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const ForgotPasswordScreen(),
        ),
      ),
      GoRoute(
        path: '/store',
        name: storeScreen,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const StoreScreen(),
        ),
        routes: [
          GoRoute(
            path: '$productsCategoryScreen/:categoryName',
            name: productsCategoryScreen,
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: ProductsCategoryScreen(
                categoryName: state.params['categoryName']!,
              ),
            ),
          ),
          GoRoute(
            path: 'all-products',
            name: allProductsScreen,
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: AllProductsScreen(
                allProducts: state.extra! as List<ProductsE>,
              ),
            ),
          ),
          GoRoute(
            path: 'search',
            name: searchProductsScreen,
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: SearchProductsScreen(
                products: state.extra as List<ProductsE>,
              ),
            ),
          ),
          GoRoute(
            path: 'all-brands',
            name: allBrandsScreen,
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: AllBrandsScreen(
                allBrandsWithProducts: state.extra! as List<dynamic>,
              ),
            ),
          ),
          GoRoute(
            path: 'brand-products/:brandName',
            name: brandProductsScreen,
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: AllProductsOfBrandScreen(
                allProducts: state.extra! as List<ProductsE>,
                brandName: state.params['brandName']!,
              ),
            ),
          ),
          GoRoute(
            path: 'filter',
            name: filteredAndSortScreen,
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: FilterAndSortScreen(
                  categoryNames: state.extra! as List<CategoryE>),
            ),
          ),
          GoRoute(
            path: 'product-detail/:id',
            name: productDetailScreen,
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: ProductDetailScreen(
                product: state.extra! as List<ProductsE>,
                productId: state.params['id']!,
              ),
            ),
          ),
          GoRoute(
            path: 'cart',
            name: cartScreen,
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: const CartPage(),
            ),
          ),
          GoRoute(
            path: 'empty-cart',
            name: emptyCartScreen,
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: const EmptyCart(),
            ),
          ),
          GoRoute(
            path: 'favorites',
            name: favoritesScreen,
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: const FavoritesPage(),
            ),
          ),
          GoRoute(
            path: 'order-detail',
            name: orderDetailScreen,
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: OrderDetailScreen(
                order: state.extra as List<dynamic>,
              ),
            ),
            routes: [
              GoRoute(
                path: 'payment-method',
                name: paymentDetailScreen,
                pageBuilder: (context, state) => MaterialPage<void>(
                  key: state.pageKey,
                  child: const PaymentDetailScreen(),
                ),
              ),
              GoRoute(
                path: 'shipping-address',
                name: shippingAddressScreen,
                pageBuilder: (context, state) => MaterialPage<void>(
                  key: state.pageKey,
                  child: const ShippingAddressScreen(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: 'order-placed/:orderId',
            name: orderPlaceSuccessScreen,
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: OrderPlaceSuccessScreen(
                orderId: state.params['orderId'].toString(),
              ),
            ),
          ),
          GoRoute(
            path: 'order-status',
            name: orderStatusScreen,
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: const OrderStatusScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/orderHistory',
        name: orderHistory,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const OrderHistoryScreen(),
        ),
        routes: [
          GoRoute(
            path: 'orderHistoryDetail',
            name: orderHistoryDetail,
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: OrderHistoryDetail(orderDetail: state.extra as OrderE),
            ),
          ),
        ],
      ),
      GoRoute(
          path: '/address-screen',
          name: addressScreen,
          pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: const AddresssScreen(),
              ),
          routes: [
            GoRoute(
              path: 'change-address',
              name: changeAddressScreen,
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: ChangeAddressScreen(addressToChange: state.extra),
              ),
            ),
          ]),
      GoRoute(
        path: '/credit-cards',
        name: creditCardsScreen,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const CreditCardsScreen(),
        ),
      ),
    ],
  );

  static GoRouter get router => _router;
}
