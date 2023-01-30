// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:wtech_ecommerce/core/routes/app_route.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/validators/search_validator.dart';
import '../../../../core/widgets/scaffold_body.dart';
import '../../domain/entities/products_entity.dart';

class SearchProductsScreen extends StatelessWidget {
  const SearchProductsScreen({
    Key? key,
    required this.products,
  }) : super(key: key);
  final List<ProductsE> products;
  static final ValueNotifier<List<String>> _searchedProduct = ValueNotifier([]);
  @override
  Widget build(BuildContext context) {
    var productNames = products.isNotEmpty
        ? products.map<String>((element) => element.name).toList()
        : [];
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text(
          'SEARCH',
        ),
        actions: [
          IconButton(
            onPressed: () {
              _searchedProduct.value.clear();
              search.reset();
              context.pop();
            },
            icon: Icon(
              Icons.clear,
              color: AppTheme.white,
            ),
          ),
          SizedBox(width: 10.h),
        ],
      ),
      body: ScaffoldBody(
        child: ReactiveForm(
          formGroup: search,
          child: productNames.isNotEmpty
              ? Column(
                  children: [
                    SizedBox(height: 30.h),
                    Text(
                      'Find your Products',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      'Search through more than 1000+ Products',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    SizedBox(height: 30.h),
                    ReactiveTextField(
                      formControlName: 'Search',
                      onChanged: (FormControl<String?> control) {
                        var queryResult = productNames.where(
                          (element) => element.toLowerCase().contains(
                                control.value!.toLowerCase(),
                              ),
                        );
                        _searchedProduct.value = [...queryResult];
                        if (control.value!.isEmpty) {
                          _searchedProduct.value.clear();
                        }
                      },
                      validationMessages: searchValidators(),
                      decoration: const InputDecoration(
                        label: Text('Search'),
                        suffixIcon: Icon(CupertinoIcons.search),
                      ),
                    ),
                    Expanded(
                      child: ValueListenableBuilder<List<String>>(
                        valueListenable: _searchedProduct,
                        builder: (context, value, child) {
                          if (value.isEmpty) {
                            return const SizedBox();
                          } else {
                            return ListView.builder(
                              itemCount: value.length,
                              itemBuilder: (context, index) {
                                // ignore: unused_local_variable
                                Color? selectedItem;
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 12.0.h),
                                  child: InkWell(
                                    onTap: () {
                                      var selectedProduct = products.firstWhere(
                                        (element) =>
                                            element.name == value[index],
                                      );

                                      context.pushNamed(
                                        productDetailScreen,
                                        params: {'id': selectedProduct.id},
                                        extra: products,
                                      );
                                      search.reset();
                                      _searchedProduct.value.clear();
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          leading: CachedNetworkImage(
                                              width: 50.w,
                                              imageUrl: products
                                                  .firstWhere(
                                                    (element) {
                                                      return element.name ==
                                                          value[index];
                                                    },
                                                  )
                                                  .imageUrls
                                                  .first),
                                          title: Text(
                                            value[index],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                        const Divider(thickness: 3),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30.h),
                    Text(
                      'Find your Products',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      'There is no products available to search',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
