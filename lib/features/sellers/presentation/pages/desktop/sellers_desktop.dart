import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:wtech_dashboard/core/routes/app_routes.dart';
import 'package:wtech_dashboard/core/validators/search_validator.dart';
import 'package:wtech_dashboard/core/widgets/button.dart';
import 'package:wtech_dashboard/core/widgets/drop_down_button.dart';
import 'package:wtech_dashboard/core/widgets/main_container.dart';
import 'package:wtech_dashboard/core/widgets/r_text_field.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../products/presentation/widgets/paginator.dart';

class SellersPageDesktop extends StatelessWidget {
  const SellersPageDesktop({super.key});

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
                Text('Sellers', style: Theme.of(context).textTheme.headline4),
                ButtonPrimary(
                  text: 'Create new',
                  iconData: Icons.add,
                  onPressed: () {},
                ),
              ],
            ),
            MainContainer(
              height: MediaQuery.of(context).size.height * 0.70,
              addPadding: false,
              child: ReactiveForm(
                formGroup: search,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14.0,
                        vertical: 14.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          const Expanded(
                            flex: 2,
                            child: RTextFormField(
                              controllerName: 'Search',
                              label: 'Search',
                              hintText: 'type...',
                            ),
                          ),
                          const Spacer(),
                          Wrap(
                            spacing: 20,
                            children: const [
                              DropDownButtonCustom(
                                menutItems: [],
                                hintText: 'Date',
                                iconData: Icons.compare_arrows_sharp,
                              ),
                              DropDownButtonCustom(
                                menutItems: [],
                                hintText: 'Status',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Scrollbar(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          dataRowHeight: 70,
                          columns: [
                            DataColumn(
                              label: Text(
                                'Seller',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Email',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Status',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Joined',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Action',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                          rows: [
                            DataRow(
                              selected: true,
                              cells: [
                                DataCell(
                                  ListTile(
                                    leading: const CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                                    title: Text('Mustafe Hassan',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    subtitle: Text('Seller ID: #5431',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              color: AppColor.captionColor
                                                  .withOpacity(0.5),
                                            )),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    'mustafe3332@gmail.com',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: AppColor.orange.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Inactive',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: AppColor.orange,
                                          ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    '27.10.2022',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                DataCell(
                                  ButtonPrimary(
                                    width: 100,
                                    text: 'Detail',
                                    onPressed: () {
                                      context.pushNamed(sellerProfileScreen);
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Paginator(
              currentPage: ValueNotifier(1),
              length: 3,
              onPageChanged: (int index) {},
            ),
          ],
        ),
      ),
    );
  }
}
