// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/functions/snackbars.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/drawer.dart';
import '../../../../core/widgets/drawer_icon.dart';
import '../../../../core/widgets/scaffold_body.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({
    Key? key,
    required this.allBrandsWithProducts,
  }) : super(key: key);
  final List<dynamic> allBrandsWithProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        leading: const DrawerOpen(),
        title: const Text('ALL BRANDS'),
        actions: [
          SizedBox(width: 10.w),
          IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              CupertinoIcons.clear,
              color: AppTheme.white,
            ),
          ),
          SizedBox(width: 15.w),
        ],
      ),
      body: ScaffoldBody(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 30,
                  childAspectRatio: 1 / 1,
                ),
                itemCount: allBrandsWithProducts[0].length,
                itemBuilder: (context, index) {
                  return DelayedDisplay(
                    delay: const Duration(milliseconds: 90),
                    fadingDuration: const Duration(milliseconds: 350),
                    slidingBeginOffset: Offset.fromDirection(3.2),
                    slidingCurve: Curves.easeInOut,
                    child: InkWell(
                      onTap: () {
                        if (allBrandsWithProducts[1] == null) {
                          showSnackBar(
                            context: context,
                            iconData: Icons.info,
                            title: 'No products found for this brand',
                            statusColor: AppTheme.red,
                          );
                        } else {
                          context.pushNamed(
                            brandProductsScreen,
                            params: {
                              'brandName':
                                  allBrandsWithProducts[0][index].brandName,
                            },
                            extra: allBrandsWithProducts[1],
                          );
                        }
                      },
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: allBrandsWithProducts[0][index]
                                      .brandImageUrl,
                                  width: 90.w,
                                  height: 90.h,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            allBrandsWithProducts[0][index].brandName,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
