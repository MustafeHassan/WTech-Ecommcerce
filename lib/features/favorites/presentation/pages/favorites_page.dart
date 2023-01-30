import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wtech_ecommerce/core/widgets/loading.dart';
import 'package:wtech_ecommerce/features/favorites/presentation/pages/empty_favorites.dart';

import 'package:wtech_ecommerce/features/store/presentation/bloc/products/products_bloc.dart';

import '../../../../core/routes/app_route.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/scaffold_body.dart';
import '../../../store/presentation/widgets/icon_box.dart';
import '../bloc/favorites_bloc.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);
  static final ValueNotifier<bool> _isRemoveEnabled = ValueNotifier(false);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return const Loading();
        }
        if (state is FavoritesLoaded) {
          if (BlocProvider.of<FavoritesBloc>(context).favorites.isNotEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'FAVORITES',
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      FavoritesPage._isRemoveEnabled.value =
                          !FavoritesPage._isRemoveEnabled.value;
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ValueListenableBuilder<bool>(
                          valueListenable: FavoritesPage._isRemoveEnabled,
                          builder: (context, value, child) {
                            return GridView.builder(
                              primary: false,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 30,
                                childAspectRatio: 1 / 1,
                              ),
                              itemCount: BlocProvider.of<FavoritesBloc>(context)
                                  .favorites
                                  .length,
                              itemBuilder: (context, index) {
                                return BlocBuilder<ProductsBloc, ProductsState>(
                                  builder: (context, pro) {
                                    return InkWell(
                                      onTap: () {
                                        context.goNamed(
                                          productDetailScreen,
                                          params: {
                                            'id':
                                                BlocProvider.of<FavoritesBloc>(
                                                        context)
                                                    .favorites[index]
                                                    .id
                                          },
                                          extra:
                                              (pro as AllProductsReceivedState)
                                                  .products,
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Stack(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: BlocProvider.of<
                                                              FavoritesBloc>(
                                                          context)
                                                      .favorites[index]
                                                      .imageUrl,
                                                  width: 120.w,
                                                  height: 120.h,
                                                ),
                                                Visibility(
                                                  visible: value,
                                                  child: Positioned(
                                                    bottom: 0,
                                                    right: 0,
                                                    child: IconBox(
                                                      scale: 0.44,
                                                      onTap: () {
                                                        if (value) {
                                                          context
                                                              .read<
                                                                  FavoritesBloc>()
                                                              .add(
                                                                ProductRemovedFromFavorites(
                                                                  id: BlocProvider.of<
                                                                              FavoritesBloc>(
                                                                          context)
                                                                      .favorites[
                                                                          index]
                                                                      .id,
                                                                ),
                                                              );
                                                        } else {}
                                                      },
                                                      iconPath: AppIcons.trash,
                                                      boxColor: AppTheme.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                              BlocProvider.of<FavoritesBloc>(
                                                      context)
                                                  .favorites[index]
                                                  .name,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1),
                                          Text(
                                            "\$${BlocProvider.of<FavoritesBloc>(context).favorites[index].price}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const EmptyFavorites();
          }
        }
        return const EmptyFavorites();
      },
    );
  }
}
