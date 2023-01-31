import 'package:flutter/material.dart';
import 'package:wtech_dashboard/core/widgets/main_container.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/drop_down_button.dart';

class TransactionsPageMobile extends StatefulWidget {
  const TransactionsPageMobile({super.key});

  @override
  State<TransactionsPageMobile> createState() => _TransactionsPageMobileState();
}

class _TransactionsPageMobileState extends State<TransactionsPageMobile> {
  static final List<Map> rowData = [
    {
      'TransactionID': '221',
      'Paid': '\$321.00',
      'Method': Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColor.captionColor.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Mastercard_2019_logo.svg/1200px-Mastercard_2019_logo.svg.png',
              height: 25,
              width: 25,
            ),
          ),
          const Text(
            'Master Card',
          ),
        ],
      ),
      'Created': '10.11.2022, 14:43',
      'Action': const Text(
        'View',
        style: TextStyle(fontSize: 15),
      ),
    }
  ];
  bool showDetail = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Transactions',
                    style: Theme.of(context).textTheme.headline4),
                ButtonPrimary(
                  text: 'Create new',
                  iconData: Icons.add,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 25),
            MainContainer(
              height: MediaQuery.of(context).size.height * 0.7,
              addPadding: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                  Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: DataTable(
                          columnSpacing: 60,
                          columns: [
                            DataColumn(
                                label: Text('TransactionID',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ))),
                            DataColumn(
                                label: Text('Paid',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ))),
                            DataColumn(
                                label: Text('Method',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ))),
                            DataColumn(
                                label: Text('Created',
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
                                  Text('${rowData[index]['TransactionID']}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ),
                                DataCell(
                                  Text(
                                    '${rowData[index]['Paid']}',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                DataCell(
                                  rowData[index]['Method'],
                                ),
                                DataCell(
                                  Text(
                                    '${rowData[index]['Created']}',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                DataCell(
                                  Material(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          showDetail = !showDetail;
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColor.captionColor
                                                .withOpacity(0.2),
                                          ),
                                        ),
                                        child: rowData[index]['Action'],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: showDetail ? 15 : 0),
            MainContainer(
              border: true,
              height: MediaQuery.of(context).size.height * 0.7,
              child: showDetail == false
                  ? Center(
                      child: Text(
                        'To view Transaction information, click in the View ',
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Transaction Detail',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                  ),
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Supplier:',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                            ),
                          ),
                          Text('Tompa Lake',
                              style: Theme.of(context).textTheme.caption!),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Date:',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                            ),
                          ),
                          Text('October 12, 2022',
                              style: Theme.of(context).textTheme.caption!),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Billing Address:',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                            ),
                          ),
                          Text(
                            '190I Thompride Cir, Shiek, Huawii 38221',
                            style: Theme.of(context).textTheme.caption!,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'VAT ID',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                            ),
                          ),
                          Text(
                            '33853203856004',
                            style: Theme.of(context).textTheme.caption!,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Email:',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                            ),
                          ),
                          Text(
                            'bussinessCamp@example.com',
                            style: Theme.of(context).textTheme.caption!,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Item Purchased:',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                            ),
                          ),
                          Text(
                            'Adidas Ranin - Black',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: AppColor.primaryColor,
                                    ),
                          ),
                          Text(
                            'Adidas Ranin - Black',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: AppColor.primaryColor,
                                    ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Paybal:',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                            ),
                          ),
                          Text(
                            'customer@example.com',
                            style: Theme.of(context).textTheme.caption!,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Paid',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 17,
                                    ),
                              ),
                              Text(
                                '\$43322',
                                style: Theme.of(context).textTheme.headline4!,
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Material(
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        AppColor.captionColor.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text('Download Recipe',
                                    style: Theme.of(context).textTheme.caption),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
