import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:wtech_dashboard/core/routes/app_routes.dart';
import 'package:wtech_dashboard/core/theme/colors.dart';
import 'package:wtech_dashboard/core/widgets/button.dart';
import 'package:wtech_dashboard/features/orders/presentation/widgets/order_table.dart';
import 'package:wtech_dashboard/features/products/presentation/widgets/paginator.dart';

import '../../../../../core/validators/search_validator.dart';
import '../../../../../core/widgets/drop_down_button.dart';
import '../../../../../core/widgets/main_container.dart';
import '../../../../../core/widgets/r_text_field.dart';

class OrdersPageDesktop extends StatelessWidget {
  const OrdersPageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Orders', style: Theme.of(context).textTheme.headline4),
                ButtonPrimary(
                  text: 'Create new',
                  iconData: Icons.add,
                  onPressed: () {},
                ),
              ],
            ),
            MainContainer(
              addPadding: false,
              height: 90,
              child: ReactiveForm(
                formGroup: search,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: RTextFormField(
                              controllerName: 'Search',
                              label: 'Search',
                              validationMessages: searchValidators(),
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(right: 14),
                          child: DropDownButtonCustom(
                            width: 88,
                            menutItems: ['Last Added', 'First Added'],
                            hintText: 'Date',
                            iconData: Icons.compare_arrows,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 14),
                          child: DropDownButtonCustom(
                            width: 88,
                            menutItems: ['Last Added', 'First Added'],
                            hintText: 'Status',
                            iconData: Icons.compare_arrows,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
            MainContainer(
              addMargin: false,
              height: MediaQuery.of(context).size.height * 0.53,
              child: OrderDataTable(
                columns: const [
                  'ID',
                  'Name',
                  'Email',
                  'Total',
                  'Status',
                  'Date',
                  'Action',
                ],
                rows: [
                  {
                    'ID': '123',
                    'Name': 'Mustafe Hassan',
                    'Email': 'Mustafe3332@gmail.com',
                    'Total': '\$2111',
                    'Status': 'Delivered',
                    'Date': '10.12/2022',
                    'Action': PopupMenuButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      position: PopupMenuPosition.under,
                      child: const Icon(
                        Icons.more_horiz,
                      ),
                      onSelected: (value) {},
                      itemBuilder: (context) {
                        return List.generate(
                          3,
                          (index) => PopupMenuItem(
                            onTap: () {
                              context.pushNamed(orderDetailScreen);
                            },
                            height: 10,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 4),
                            child: Text(
                              'view',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ).toList();
                      },
                    ),
                  },
                ],
              ),
            ),
            const SizedBox(height: 10),
            Paginator(
              currentPage: ValueNotifier(0),
              length: 4,
              onPageChanged: (_) {},
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
