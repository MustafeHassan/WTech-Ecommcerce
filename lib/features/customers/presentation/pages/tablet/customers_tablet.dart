import 'package:flutter/material.dart';
import 'package:wtech_dashboard/core/widgets/main_container.dart';

import '../../../../../core/theme/colors.dart';

class CustomersPageTablet extends StatefulWidget {
  const CustomersPageTablet({super.key});

  @override
  State<CustomersPageTablet> createState() => _CustomersPageTabletState();
}

class _CustomersPageTabletState extends State<CustomersPageTablet> {
  final List<Map> rowData = [
    {
      'Profile Picture': CircleAvatar(
        backgroundColor: AppColor.bgColor,
        child: const Icon(Icons.person),
      ),
      'Full Name': 'Mustafe Hassan',
      'Email': 'mustafe3332@gmail.com',
      'Phone Number': '+256 076 2081 470',
      'Address': 'Nalokalongo - National Water / Kampala - Uganda',
      'Action': const Icon(Icons.person_pin_rounded),
    }
  ];
  Map? userData;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customers', style: Theme.of(context).textTheme.headline4),
            const SizedBox(height: 25),
            MainContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(
                              label: Text('Profile Picture',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ))),
                          DataColumn(
                              label: Text('Full Name',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ))),
                          DataColumn(
                              label: Text('Email',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ))),
                          DataColumn(
                              label: Text('phone Number',
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
                                rowData[index]['Profile Picture'],
                              ),
                              DataCell(
                                Text(
                                  '${rowData[index]['Full Name']}',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              DataCell(
                                Text(
                                  '${rowData[index]['Email']}',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              DataCell(
                                Text(
                                  '${rowData[index]['Phone Number']}',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              DataCell(
                                rowData[index]['Action'],
                                onTap: () {
                                  setState(() {
                                    userData = rowData[index];
                                  });
                                },
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
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainContainer(
                  child: userData == null
                      ? Center(
                          child: Text(
                            'To view user information, click in the Action Column',
                            style: Theme.of(context).textTheme.caption,
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 12),
                            Center(
                              child: Transform.scale(
                                scale: 2.4,
                                child: (userData?['Profile Picture']
                                    as CircleAvatar?),
                              ),
                            ),
                            const SizedBox(height: 35),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text.rich(
                                TextSpan(
                                  text: 'Full Name: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: AppColor.captionColor
                                            .withOpacity(0.3),
                                      ),
                                  children: [
                                    TextSpan(
                                      text: userData?['Full Name'] ?? '',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text.rich(
                                TextSpan(
                                  text: 'Email: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: AppColor.captionColor
                                            .withOpacity(0.3),
                                      ),
                                  children: [
                                    TextSpan(
                                      text: userData?['Email'] ?? '',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text.rich(
                                TextSpan(
                                  text: 'Address: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: AppColor.captionColor
                                            .withOpacity(0.3),
                                      ),
                                  children: [
                                    TextSpan(
                                      text: userData?['Address'] ?? '',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  'Delete',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: AppColor.red,
                                      ),
                                ),
                                Text(
                                  'Edit',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: AppColor.green,
                                      ),
                                ),
                              ],
                            )
                          ],
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
