import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wtech_dashboard/core/widgets/button.dart';
import 'package:wtech_dashboard/core/widgets/main_container.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/widgets/drop_down_button.dart';
import '../../../../products/presentation/widgets/paginator.dart';

class ReviewsPageMobile extends StatelessWidget {
  const ReviewsPageMobile({super.key});

  static final List<Map> rowData = [
    {
      'ID': '221',
      'Product': 'A Line mini dress in blue',
      'Name': 'Mustafe Hassan',
      'Rating': RatingBarIndicator(
        itemSize: 20,
        unratedColor: AppColor.captionColor,
        itemCount: 5,
        rating: 3.2,
        itemBuilder: (context, index) {
          return Icon(
            Icons.star,
            color: AppColor.orange,
          );
        },
      ),
      'Date': '10.11.2022',
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
              onTap: () {},
              height: 10,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Text(
                'view',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ).toList();
        },
      ),
    }
  ];

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
                Text('Reviews', style: Theme.of(context).textTheme.headline4),
                ButtonPrimary(
                  text: 'Create new',
                  iconData: Icons.add,
                  onPressed: () {},
                ),
              ],
            ),
            MainContainer(
              height: MediaQuery.of(context).size.height * 0.66,
              addPadding: false,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 14),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        DropDownButtonCustom(
                            menutItems: [], hintText: 'Status'),
                        DropDownButtonCustom(
                          menutItems: [],
                          hintText: 'Date',
                          iconData: Icons.compare_arrows,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 90,
                        columns: [
                          DataColumn(
                              label: Text('ID',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ))),
                          DataColumn(
                              label: Text('Product',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ))),
                          DataColumn(
                              label: Text('Name',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ))),
                          DataColumn(
                              label: Text('Rating',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ))),
                          DataColumn(
                              label: Text('Date',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ))),
                          DataColumn(
                              label: Text('Action',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ))),
                        ],
                        rows: List.generate(
                          rowData.length,
                          (index) => DataRow(
                            cells: [
                              DataCell(
                                Text('${rowData[index]['ID']}',
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              ),
                              DataCell(
                                Text(
                                  '${rowData[index]['Product']}',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              DataCell(
                                Text(
                                  '${rowData[index]['Name']}',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              DataCell(rowData[index]['Rating']),
                              DataCell(
                                Text(
                                  '${rowData[index]['Date']}',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              DataCell(
                                rowData[index]['Action'],
                              ),
                            ],
                          ),
                        ).toList(),
                      ),
                    ),
                  ),
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
