import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:wtech_ecommerce/core/network/internet_connection_checker.dart';
import 'package:wtech_ecommerce/core/network/network_info.dart';
import 'package:wtech_ecommerce/features/authentication/data/datasources/auth_remote_data_sources.dart';
import 'package:wtech_ecommerce/features/authentication/data/repositories/auth_repository_imp.dart';
import 'package:wtech_ecommerce/features/authentication/domain/repositories/auth_repository.dart';
import 'package:wtech_ecommerce/features/authentication/domain/usecases/sign_in_facebook.dart';
import 'package:wtech_ecommerce/features/authentication/domain/usecases/sign_in_with_email_and_password_usecase.dart';
import 'package:wtech_ecommerce/features/authentication/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:wtech_ecommerce/features/authentication/domain/usecases/sign_out_usecase.dart';
import 'package:wtech_ecommerce/features/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:wtech_ecommerce/features/favorites/data/repositories/favorites_repository_imp.dart';
import 'package:wtech_ecommerce/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:wtech_ecommerce/features/favorites/domain/usecases/add_product_to_favorites_usecase.dart';
import 'package:wtech_ecommerce/features/favorites/domain/usecases/get_all_favorites_products_usecase.dart';
import 'package:wtech_ecommerce/features/favorites/domain/usecases/remove_product_from_favorite_usecase.dart';
import 'package:wtech_ecommerce/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:wtech_ecommerce/features/order/data/repositories/order_repository_imp.dart';
import 'package:wtech_ecommerce/features/order/presentation/bloc/credit_cards/credit_cards_bloc.dart';
import 'package:wtech_ecommerce/features/order/presentation/bloc/shipping_address/shipping_address_bloc.dart';
import 'package:wtech_ecommerce/features/settings/presentation/cubit/profile_picture_cubit.dart';
import 'package:wtech_ecommerce/features/store/data/datasources/store_remote_data_source.dart';
import 'package:wtech_ecommerce/features/store/data/repositories/store_repository_imp.dart';
import 'package:wtech_ecommerce/features/store/domain/repositories/store_repository.dart';
import 'package:wtech_ecommerce/features/store/domain/usecases/brands_usecase.dart';
import 'package:wtech_ecommerce/features/store/domain/usecases/category_usecase.dart';
import 'package:wtech_ecommerce/features/store/domain/usecases/products_usecase.dart';
import 'package:wtech_ecommerce/features/store/presentation/bloc/brands/brands_bloc.dart';
import 'package:wtech_ecommerce/features/store/presentation/bloc/category/category_bloc.dart';
import 'package:wtech_ecommerce/features/store/presentation/bloc/products/products_bloc.dart';

import 'features/authentication/presentation/bloc/authentication_bloc.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/favorites/data/datasources/favorites_remote_data_source.dart';
import 'features/order/data/datasources/order_remote_data_source.dart';
import 'features/order/domain/repositories/order_repository.dart';
import 'features/order/domain/usecases/get_all_credit_cards_usecase.dart';
import 'features/order/domain/usecases/get_all_orders_usecase.dart';
import 'features/order/domain/usecases/get_all_shipping_address_usecase.dart';
import 'features/order/domain/usecases/place_order_usecase.dart';
import 'features/order/domain/usecases/set_payment_usecase.dart';
import 'features/order/domain/usecases/set_shipping_address.dart';
import 'features/order/presentation/bloc/order/order_bloc.dart';
import 'firebase_options.dart';

GetIt sl = GetIt.instance;
late SharedPreferences preferences;
Future<void> initServices() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  preferences = await SharedPreferences.getInstance();

  //! Features

  //* Auth Bloc
  sl.registerFactory<AuthenticationBloc>(
    () => AuthenticationBloc(
      signout: sl(),
      signInWithEmail: sl(),
      signInWithFacebook: sl(),
      signInWithGoogle: sl(),
      signUp: sl(),
    ),
  );
  //* Store Bloc

  sl.registerFactory<CategoryBloc>(
    () => CategoryBloc(
      allCategories: sl<GetAllCategoriesUsecase>(),
    ),
  );
  sl.registerFactory<ProductsBloc>(
    () => ProductsBloc(
      allProducts: sl<GetAllProductsUsecase>(),
    ),
  );
  sl.registerFactory<BrandsBloc>(
    () => BrandsBloc(
      allBrands: sl<GetAllBrandsUsecase>(),
    ),
  );
//* Cart Bloc
  sl.registerFactory<CartBloc>(
    () => CartBloc(),
  );

  //* Favorites Bloc
  sl.registerFactory<FavoritesBloc>(
    () => FavoritesBloc(
      addToFavorites: sl<AddProductToFavoritesUsecase>(),
      getFavorites: sl<GetAllFavoriteProductsUsecase>(),
      removeFromFavorites: sl<RemoveProductFromFavoritesUsecase>(),
    ),
  );

  //* Order Bloc
  sl.registerFactory<OrderBloc>(
    () => OrderBloc(
      placeOrderUscecase: sl<PlaceOrderUscecase>(),
      getOrders: sl<GetAllOrdersUsecase>(),
    ),
  );

  //* CreditCart Bloc
  sl.registerFactory<CreditCardsBloc>(
    () => CreditCardsBloc(
      creditCardsUsecase: sl<GetAllCreditCardsUsecase>(),
      paymentUsecase: sl<SetPaymentUsecase>(),
    ),
  );

  //* ShippingAddress Bloc
  sl.registerFactory<ShippingAddressBloc>(
    () => ShippingAddressBloc(
      setShippingAddressUsecase: sl<SetShippingAddressUsecase>(),
      shippingAddressUsecase: sl<GetAllShippingAddressUsecase>(),
    ),
  );

  //* Profile Bloc
  sl.registerFactory<ProfilePictureCubit>(
    () => ProfilePictureCubit(),
  );

  //* Auth Usecases

  sl.registerLazySingleton<SignOutUscease>(
    () => SignOutUscease(authRepository: sl()),
  );

  sl.registerLazySingleton<SignInWithEmailAndPasswordUseCase>(
    () => SignInWithEmailAndPasswordUseCase(
      authRepository: sl(),
    ),
  );
  sl.registerLazySingleton<SignInWithFacebookUseCase>(
    () => SignInWithFacebookUseCase(
      authRepository: sl(),
    ),
  );

  sl.registerLazySingleton<SignInWithGoogleUsecase>(
    () => SignInWithGoogleUsecase(
      authRepository: sl(),
    ),
  );

  sl.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(
      authRepository: sl(),
    ),
  );

  //* Store Uscease

  sl.registerLazySingleton<GetAllCategoriesUsecase>(
    () => GetAllCategoriesUsecase(
      storeRepository: sl<StoreRepository>(),
    ),
  );

  sl.registerLazySingleton<GetAllProductsUsecase>(
    () => GetAllProductsUsecase(
      storeRepository: sl<StoreRepository>(),
    ),
  );

  sl.registerLazySingleton<GetAllBrandsUsecase>(
    () => GetAllBrandsUsecase(
      storeRepository: sl<StoreRepository>(),
    ),
  );

//* Favorites Uscease

  sl.registerLazySingleton<GetAllFavoriteProductsUsecase>(
    () => GetAllFavoriteProductsUsecase(
      repository: sl<FavoritesRepository>(),
    ),
  );

  sl.registerLazySingleton<AddProductToFavoritesUsecase>(
    () => AddProductToFavoritesUsecase(
      repository: sl<FavoritesRepository>(),
    ),
  );

  sl.registerLazySingleton<RemoveProductFromFavoritesUsecase>(
    () => RemoveProductFromFavoritesUsecase(
      repository: sl<FavoritesRepository>(),
    ),
  );
//* Order Usecase

  sl.registerLazySingleton<GetAllCreditCardsUsecase>(
    () => GetAllCreditCardsUsecase(
      orderRepository: sl<OrderRepository>(),
    ),
  );
  sl.registerLazySingleton<SetPaymentUsecase>(
    () => SetPaymentUsecase(
      orderRepository: sl<OrderRepository>(),
    ),
  );

  sl.registerLazySingleton<PlaceOrderUscecase>(
    () => PlaceOrderUscecase(
      orderRepository: sl<OrderRepository>(),
    ),
  );
  sl.registerLazySingleton<SetShippingAddressUsecase>(
    () => SetShippingAddressUsecase(
      orderRepository: sl<OrderRepository>(),
    ),
  );
  sl.registerLazySingleton<GetAllShippingAddressUsecase>(
    () => GetAllShippingAddressUsecase(
      orderRepository: sl<OrderRepository>(),
    ),
  );

  sl.registerLazySingleton<GetAllOrdersUsecase>(
    () => GetAllOrdersUsecase(
      orderRepository: sl<OrderRepository>(),
    ),
  );
  //*  Auth Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(networkInfo: sl(), authRemoteDataSource: sl()),
  );
  //*  Store Repository

  sl.registerLazySingleton<StoreRepository>(
    () => StoreRepositoryImp(remoteDataSource: sl<StoreRemoteDataSource>()),
  );

  //*  favorites Repository

  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImp(dataSource: sl<FavoriteRemoteDataSource>()),
  );

  //*  Order Repository

  sl.registerLazySingleton<OrderRepository>(
    () =>
        OrderRepositoryImp(orderRemoteDataSource: sl<OrderRemoteDataSource>()),
  );

  //* Netowrk Info
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(connectionChecker: sl()),
  );
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );

  //*Auth Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImp(
        emailAuth: sl(),
        firebaseAuth: sl(),
        firebaseFirestore: sl(),
        facebookAuth: sl(),
        googleSignIn: sl()),
  );
  //*Store Data Sources

  sl.registerLazySingleton<StoreRemoteDataSource>(
    () => StoreRemoteDataSourceImp(
      firestore: sl<FirebaseFirestore>(),
    ),
  );

  //*Favorites Data Sources
  sl.registerLazySingleton<FavoriteRemoteDataSource>(
    () => FavoriteRemoteDataSourceImp(
      auth: sl<FirebaseAuth>(),
      firestore: sl<FirebaseFirestore>(),
    ),
  );

  //*Order Data Sources
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImp(
      auth: sl<FirebaseAuth>(),
      firestore: sl<FirebaseFirestore>(),
    ),
  );

  //!! External

  sl.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );
  sl.registerLazySingleton<EmailAuth>(
    () => EmailAuth(sessionName: 'Verify Otp Code'),
  );
  sl.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  sl.registerLazySingleton<FacebookAuth>(
    () => FacebookAuth.instance,
  );
  sl.registerLazySingleton<GoogleSignIn>(
    () => GoogleSignIn(),
  );
}
