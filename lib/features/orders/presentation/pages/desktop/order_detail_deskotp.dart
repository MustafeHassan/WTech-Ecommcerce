import 'package:flutter/material.dart';
import 'package:wtech_dashboard/core/theme/colors.dart';
import 'package:wtech_dashboard/core/widgets/button.dart';
import 'package:wtech_dashboard/core/widgets/drop_down_button.dart';
import 'package:wtech_dashboard/core/widgets/main_container.dart';

import '../../widgets/address_info.dart';
import '../../widgets/custom_table_header.dart';
import '../../widgets/customer_info.dart';
import '../../widgets/ordered_products.dart';
import '../../widgets/shipping_info.dart';
import '../../widgets/total_payment.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Order Detail', style: Theme.of(context).textTheme.headline4),
          Expanded(
            child: MainContainer(
              height: 0,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Wrap(spacing: 10, children: [
                          const Icon(
                            Icons.calendar_today,
                            color: AppColor.black,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Wed, Aug 13, 2022,4:21PM',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                '#222431',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ]),
                        Wrap(
                          spacing: 10,
                          children: [
                            const DropDownButtonCustom(
                                height: 41,
                                width: 200,
                                menutItems: [],
                                hintText: 'Change Status'),
                            ButtonWithIcon(
                              text: 'Save',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        CustomerInfo(
                          email: 'Mustafe3332@gmail.com',
                          name: 'Mustafe Hassan',
                          phoneNumber: '32321 2321',
                        ),
                        ShippingInfo(
                            icon: Icons.local_shipping_outlined,
                            title: 'Shipping',
                            shipping: 'Fargo Express',
                            paymentMethod: 'Credit Card',
                            status: 'Proccessing'),
                        AddressInfo(
                            icon: Icons.location_on_rounded,
                            title: 'Deliver To',
                            city: 'Jampala - Uganda',
                            street: 'Nalokalongo - National Water',
                            address: 'N/A'),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              const CustomTableHeader(),
                              ...List.generate(
                                5,
                                (index) => OrderedProducts(
                                  topBorder: index == 0,
                                  imageUrl:
                                      'https://images.demandware.net/dw/image/v2/BBBV_PRD/on/demandware.static/-/Sites-master-catalog/default/dwd633af54/images/700000/704909.jpg?sw=1600',
                                  name: 'SOFA INVDA ',
                                  quantity: 1,
                                  total: 322,
                                  unitTotal: 333,
                                ),
                              ).toList(),
                              const TotalPayment(
                                shippingCost: 33,
                                subTotal: 22,
                                total: 4232,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 15),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 0.8,
                                color: AppColor.captionColor.withOpacity(0.2),
                              ),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Payment Method',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColor.captionColor
                                                .withOpacity(0.2),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Image.network(
                                          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Mastercard_2019_logo.svg/1200px-Mastercard_2019_logo.svg.png',
                                          height: 25,
                                          width: 25,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Master Card: ************* 54321',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Text.rich(
                                      TextSpan(
                                        text: 'Bussiness Name: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              color: AppColor.captionColor
                                                  .withOpacity(0.6),
                                            ),
                                        children: [
                                          TextSpan(
                                            text: 'Master Card, Inc',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Text.rich(
                                      TextSpan(
                                        text: 'Phone Number: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              color: AppColor.captionColor
                                                  .withOpacity(0.6),
                                            ),
                                        children: [
                                          TextSpan(
                                            text: '+91 (434) 324 6643 023',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
