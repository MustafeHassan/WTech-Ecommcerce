import 'package:flutter/material.dart';
import 'package:wtech_dashboard/core/theme/colors.dart';
import 'package:wtech_dashboard/core/widgets/button.dart';
import 'package:wtech_dashboard/core/widgets/drop_down_button.dart';
import 'package:wtech_dashboard/core/widgets/main_container.dart';
import 'package:wtech_dashboard/features/orders/presentation/widgets/credit_card_info_mobile.dart';

import '../../widgets/address_info.dart';
import '../../widgets/custom_table_header.dart';
import '../../widgets/customer_info.dart';
import '../../widgets/ordered_products.dart';
import '../../widgets/shipping_info.dart';
import '../../widgets/total_payment.dart';

class OrderDetailMobile extends StatelessWidget {
  const OrderDetailMobile({super.key});

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
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
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
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: DropDownButtonCustom(
                              height: 41,
                              width: 200,
                              menutItems: [],
                              hintText: 'Change Status'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ButtonWithIcon(
                            text: 'Save',
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 15),
                    const CustomerInfo(
                      email: 'Mustafe3332@gmail.com',
                      name: 'Mustafe Hassan',
                      phoneNumber: '32321 2321',
                    ),
                    const ShippingInfo(
                        icon: Icons.local_shipping_outlined,
                        title: 'Shipping',
                        shipping: 'Fargo Express',
                        paymentMethod: 'Credit Card',
                        status: 'Proccessing'),
                    const AddressInfo(
                        icon: Icons.location_on_rounded,
                        title: 'Deliver To',
                        city: 'Jampala - Uganda',
                        street: 'Nalokalongo - National Water',
                        address: 'N/A'),
                    const SizedBox(height: 25),
                    Column(
                      children: [
                        const SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: 500,
                            child: CustomTableHeader(),
                          ),
                        ),
                        ...List.generate(
                          5,
                          (index) => SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              width: 500,
                              child: OrderedProducts(
                                topBorder: index == 0,
                                imageUrl:
                                    'https://images.demandware.net/dw/image/v2/BBBV_PRD/on/demandware.static/-/Sites-master-catalog/default/dwd633af54/images/700000/704909.jpg?sw=1600',
                                name: 'SOFA INVDA ',
                                quantity: 1,
                                total: 322,
                                unitTotal: 333,
                              ),
                            ),
                          ),
                        ).toList(),
                        const TotalPayment(
                          shippingCost: 33,
                          subTotal: 22,
                          total: 4232,
                        ),
                      ],
                    ),
                    const CreditCardInfoMobile(
                      businnessName: 'Master Card, Inc',
                      cardNumber: 'Master Card: ************* 54321',
                      phoneNumber: 'N/A',
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
