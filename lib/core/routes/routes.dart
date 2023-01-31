import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wtech_dashboard/features/authentication/presentation/screen/email_sent.screen.dart';
import 'package:wtech_dashboard/features/authentication/presentation/screen/forgot_password_screen.dart';
import 'package:wtech_dashboard/features/authentication/presentation/screen/log_in_screen.dart';
import 'package:wtech_dashboard/features/customers/presentation/pages/desktop/customers_desktop.dart';
import 'package:wtech_dashboard/features/customers/presentation/pages/mobile/customers_mobile.dart';
import 'package:wtech_dashboard/features/customers/presentation/pages/tablet/customers_tablet.dart';
import 'package:wtech_dashboard/features/dashboard/presentation/pages/desktop/dashboard_desktop.dart';
import 'package:wtech_dashboard/features/dashboard/presentation/pages/mobile/dashboard_mobile.dart';
import 'package:wtech_dashboard/features/orders/presentation/pages/desktop/order_detail_deskotp.dart';
import 'package:wtech_dashboard/features/orders/presentation/pages/desktop/orders_desktop.dart';
import 'package:wtech_dashboard/features/orders/presentation/pages/mobile/order_detail_mobile.dart';
import 'package:wtech_dashboard/features/orders/presentation/pages/mobile/orders_mobile.dart';
import 'package:wtech_dashboard/features/orders/presentation/pages/tablet/order_detail_tablet.dart';
import 'package:wtech_dashboard/features/orders/presentation/pages/tablet/orders_tablet.dart';
import 'package:wtech_dashboard/features/products/presentation/pages/desktop/add_products.dart';
import 'package:wtech_dashboard/features/products/presentation/pages/desktop/brands_desktop.dart';
import 'package:wtech_dashboard/features/products/presentation/pages/desktop/categories_desktop.dart';
import 'package:wtech_dashboard/features/products/presentation/pages/desktop/products_desktop.dart';
import 'package:wtech_dashboard/features/products/presentation/pages/mobile/add_products_mobile.dart';
import 'package:wtech_dashboard/features/products/presentation/pages/mobile/brands_mobile.dart';
import 'package:wtech_dashboard/features/products/presentation/pages/mobile/products_mobile.dart';
import 'package:wtech_dashboard/features/products/presentation/pages/tablet/add_products_tablet.dart';
import 'package:wtech_dashboard/features/products/presentation/pages/tablet/brands_tablet.dart';
import 'package:wtech_dashboard/features/products/presentation/pages/tablet/products_tablet.dart';
import 'package:wtech_dashboard/features/reviews/presentation/pages/desktop/reviews_desktop.dart';
import 'package:wtech_dashboard/features/reviews/presentation/pages/mobile/reviews_mobile.dart.dart';
import 'package:wtech_dashboard/features/reviews/presentation/pages/tablet/reviews_tablet.dart';
import 'package:wtech_dashboard/features/sellers/presentation/pages/desktop/seller_profile_screen.dart';
import 'package:wtech_dashboard/features/sellers/presentation/pages/desktop/sellers_desktop.dart';
import 'package:wtech_dashboard/features/sellers/presentation/pages/mobile/seller_profile_mobile.dart';
import 'package:wtech_dashboard/features/sellers/presentation/pages/mobile/sellers_mobile.dart';
import 'package:wtech_dashboard/features/sellers/presentation/pages/tablet/seller_profile_tablet.dart';
import 'package:wtech_dashboard/features/sellers/presentation/pages/tablet/sellers_tablet.dart';
import 'package:wtech_dashboard/features/settings/presentation/pages/desktop/settings_desktop.dart';
import 'package:wtech_dashboard/features/settings/presentation/pages/mobile/settings_mobile.dart';
import 'package:wtech_dashboard/features/settings/presentation/pages/tablet/settings_tablet.dart';
import 'package:wtech_dashboard/features/statistics/presentation/pages/desktop/statistics_desktop.dart';
import 'package:wtech_dashboard/features/statistics/presentation/pages/mobile/statistics_mobile.dart';
import 'package:wtech_dashboard/features/statistics/presentation/pages/tablet/statistics_tablet.dart';
import 'package:wtech_dashboard/features/transactions/presentation/pages/desktop/transaction_desktop.dart';
import 'package:wtech_dashboard/features/transactions/presentation/pages/mobile/transactions_mobile.dart';
import 'package:wtech_dashboard/features/transactions/presentation/pages/tablet/transactions_tablet.dart';
import '../../service_locator.dart' as di;
import '../../admin_screen.dart';
import '../../features/dashboard/presentation/pages/tablet/dashboard_tablet.dart';
import '../../features/products/presentation/pages/mobile/categories_mobile.dart';
import '../../features/products/presentation/pages/tablet/categories_tablet.dart';
import '../../responsiveness.dart';
import 'app_routes.dart';
import 'error_page.dart';
import 'page_transitons.dart';

class AppRouter {
  AppRouter._();
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: di.preferences.getBool('isLoggedIn') == true
        ? loginScreen
        : dashboardScreen,
    // initialLocation: dashboardScreen,
    urlPathStrategy: UrlPathStrategy.path,
    errorBuilder: (context, state) {
      if (kDebugMode) {
        print(state.error);
      }
      return const PageNotFound();
    },
    //* Auth
    routes: [
      GoRoute(
        path: '/log-in',
        name: loginScreen,
        pageBuilder: (context, state) => customPageBuilder(
          state: state,
          context: context,
          child: const LogInScreen(),
        ),
      ),
      GoRoute(
        path: '/forgot-password',
        name: forgotPasswordScreen,
        pageBuilder: (context, state) => customPageBuilder(
          state: state,
          context: context,
          child: const ForgotPasswordScreen(),
        ),
      ),
      GoRoute(
        path: '/email-sent',
        name: emailSentScreen,
        pageBuilder: (context, state) => customPageBuilder(
          state: state,
          context: context,
          child: const EmailSentScreen(),
        ),
      ),
      //************* */
      //* Dashboard
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => ShellAdminScree(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            name: dashboardScreen,
            pageBuilder: (context, state) => customPageBuilder(
              context: context,
              state: state,
              child: Responsiveness.isDesktop(context)
                  ? const DashboardPageDesktop()
                  : Responsiveness.isTablet(context)
                      ? const DashboardPageTablet()
                      : const DashboardPageMobile(),
            ),
          ),
          GoRoute(
            path: '/products',
            name: productsScreen,
            pageBuilder: (context, state) => customPageBuilder(
              context: context,
              state: state,
              child: Responsiveness.isDesktop(context)
                  ? const ProductsPageDesktop()
                  : Responsiveness.isTablet(context)
                      ? const ProductsPageTablet()
                      : const ProductsPageMobile(),
            ),
            routes: [
              GoRoute(
                path: 'add-product',
                name: addProductScreen,
                pageBuilder: (context, state) => customPageBuilder(
                  context: context,
                  state: state,
                  child: Responsiveness.isDesktop(context)
                      ? const AddProductScreenDesktop()
                      : Responsiveness.isTablet(context)
                          ? const AddProductScreenTablet()
                          : const AddProductScreenMobile(),
                ),
              ),
              GoRoute(
                path: 'categories',
                name: categoriesScreen,
                pageBuilder: (context, state) => customPageBuilder(
                  context: context,
                  state: state,
                  child: Responsiveness.isDesktop(context)
                      ? const CategoriesScreenDesktop()
                      : Responsiveness.isTablet(context)
                          ? const CategoriesScreenTablet()
                          : const CategoriesScreenMobile(),
                ),
              ),
              GoRoute(
                path: 'brands',
                name: brandsScreen,
                pageBuilder: (context, state) => customPageBuilder(
                  context: context,
                  state: state,
                  child: Responsiveness.isDesktop(context)
                      ? const BrandsScreenDesktop()
                      : Responsiveness.isTablet(context)
                          ? const BrandsScreenTablet()
                          : const BrandsScreenMobile(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/orders',
            name: ordersScreen,
            pageBuilder: (context, state) => customPageBuilder(
              context: context,
              state: state,
              child: Responsiveness.isDesktop(context)
                  ? const OrdersPageDesktop()
                  : Responsiveness.isTablet(context)
                      ? const OrdersPageTablet()
                      : const OrdersPageMobile(),
            ),
            routes: [
              GoRoute(
                path: 'detail',
                name: orderDetailScreen,
                pageBuilder: (context, state) => customPageBuilder(
                  context: context,
                  state: state,
                  child: Responsiveness.isDesktop(context)
                      ? const OrderDetail()
                      : Responsiveness.isTablet(context)
                          ? const OrderDetailTablet()
                          : const OrderDetailMobile(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/customers',
            name: customersScreen,
            pageBuilder: (context, state) => customPageBuilder(
              context: context,
              state: state,
              child: Responsiveness.isDesktop(context)
                  ? const CustomersPageDesktop()
                  : Responsiveness.isTablet(context)
                      ? const CustomersPageTablet()
                      : const CustomersPageMobile(),
            ),
          ),
          GoRoute(
            path: '/statistics',
            name: statisticsScreen,
            pageBuilder: (context, state) => customPageBuilder(
              context: context,
              state: state,
              child: Responsiveness.isDesktop(context)
                  ? const StatisticsPageDesktop()
                  : Responsiveness.isTablet(context)
                      ? const StatisticsPageTablet()
                      : const StatisticsPageMobile(),
            ),
          ),
          GoRoute(
            path: '/transactions',
            name: transactionsScreen,
            pageBuilder: (context, state) => customPageBuilder(
              context: context,
              state: state,
              child: Responsiveness.isDesktop(context)
                  ? const TransactionsPageDesktop()
                  : Responsiveness.isTablet(context)
                      ? const TransactionsPageTablet()
                      : const TransactionsPageMobile(),
            ),
          ),
          GoRoute(
            path: '/reviews',
            name: reviewsScreen,
            pageBuilder: (context, state) => customPageBuilder(
              context: context,
              state: state,
              child: Responsiveness.isDesktop(context)
                  ? const ReviewsPageDesktop()
                  : Responsiveness.isTablet(context)
                      ? const ReviewsPageTablet()
                      : const ReviewsPageMobile(),
            ),
          ),
          GoRoute(
            path: '/sellers',
            name: sellersScreen,
            pageBuilder: (context, state) => customPageBuilder(
              context: context,
              state: state,
              child: Responsiveness.isDesktop(context)
                  ? const SellersPageDesktop()
                  : Responsiveness.isTablet(context)
                      ? const SellersPageTablet()
                      : const SellersPageMobile(),
            ),
            routes: [
              GoRoute(
                path: 'seller-profile',
                name: sellerProfileScreen,
                pageBuilder: (context, state) => customPageBuilder(
                  context: context,
                  state: state,
                  child: Responsiveness.isDesktop(context)
                      ? const SellerProfileDesktop()
                      : Responsiveness.isTablet(context)
                          ? const SellerProfileTablet()
                          : const SellerProfileMobile(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/settings',
            name: settingsScreen,
            pageBuilder: (context, state) => customPageBuilder(
              context: context,
              state: state,
              child: Responsiveness.isDesktop(context)
                  ? const SettingsPageDesktop()
                  : Responsiveness.isTablet(context)
                      ? const SettingsPageTablet()
                      : const SettingsPageMobile(),
            ),
          ),
        ],
      ),
    ],
  );
  static GoRouter get router => _router;
}
