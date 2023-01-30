import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:wtech_ecommerce/core/routes/app_route.dart';
import 'package:wtech_ecommerce/core/theme/animations_asset.dart';
import 'package:wtech_ecommerce/core/widgets/scaffold_body.dart';

import 'package:wtech_ecommerce/features/settings/presentation/function/functions.dart';
import 'package:wtech_ecommerce/services_locator.dart' as di;

import '../../../order/data/models/shipping_address_model.dart';

class AddresssScreen extends StatefulWidget {
  const AddresssScreen({super.key});

  @override
  State<AddresssScreen> createState() => _AddresssScreenState();
}

class _AddresssScreenState extends State<AddresssScreen> {
  @override
  void initState() {
    super.initState();
  }

  var user = jsonDecode(di.preferences.getString('user')!);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MY ADDRESS',
        ),
      ),
      body: ScaffoldBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'HOME ADDRESS',
                  style: Theme.of(context).textTheme.caption,
                ),
                TextButton(
                  onPressed: () {
                    context.pushNamed(changeAddressScreen, extra: {
                      'addressContent': user['address'],
                    });
                  },
                  child: const Text(
                    'Change',
                  ),
                )
              ],
            ),
            Text(
                '${user['address']['address line 1']},\n${user['address']['zipCode']} - ${user['address']['city']}/${user['address']['country']}',
                style: Theme.of(context).textTheme.bodyText1),
            SizedBox(height: 30.h),
            FutureBuilder(
              future: getShippingAddress(user['id']),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ShippingAddressModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Lottie.asset(miniLoading, width: 100));
                }
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        var shippingAddress = snapshot.data?[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'SHIPPING ADDRESS',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      var isDeleted =
                                          await deleteShippingAddress(
                                              uid: user['id'],
                                              zipCode:
                                                  shippingAddress!.zipCode);
                                      if (isDeleted) {
                                        setState(() {});
                                      }
                                    },
                                    child: const Text(
                                      'Delete',
                                    ),
                                  ),
                                ]),
                            Text(
                              '${shippingAddress?.addressLine1},\n${shippingAddress?.zipCode} - ${shippingAddress?.city}/${shippingAddress?.country}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
