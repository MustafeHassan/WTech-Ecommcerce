import 'package:flutter/material.dart';
import 'package:wtech_dashboard/core/theme/colors.dart';
import 'package:wtech_dashboard/core/widgets/button.dart';
import 'package:wtech_dashboard/core/widgets/main_container.dart';

import '../../../../../core/widgets/drop_down_button.dart';
import '../../../../products/presentation/widgets/products_card.dart';

class SellerProfileTablet extends StatelessWidget {
  const SellerProfileTablet({super.key});

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
                Text('Seller Profile',
                    style: Theme.of(context).textTheme.headline4),
                ButtonPrimary(
                  text: 'Create new',
                  iconData: Icons.add,
                  onPressed: () {},
                ),
              ],
            ),
            MainContainer(
              height: MediaQuery.of(context).size.height * 0.75,
              addPadding: false,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(
                          height: 150,
                          decoration: const BoxDecoration(
                            // color: AppColor.orange,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                'https://9cover.com/images/ccovers/5094419ac9e54.jpg',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 140,
                          height: 160,
                          margin: EdgeInsets.only(
                            top: 90,
                            left: MediaQuery.of(context).size.width * 0.37,
                          ),
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.white,
                            image: const DecorationImage(
                              filterQuality: FilterQuality.medium,
                              image: NetworkImage(
                                  'https://1000logos.net/wp-content/uploads/2019/06/Adidas-Logo-1991.jpg'),
                            ),
                            border: Border.all(
                              color: AppColor.captionColor.withOpacity(0.15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 10),
                            child: ListTile(
                              dense: true,
                              title: Wrap(
                                spacing: 15,
                                children: [
                                  Text(
                                    'Adidas, Inc.',
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  Icon(
                                    Icons.verified,
                                    color:
                                        AppColor.captionColor.withOpacity(0.4),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                  '3813 Ranchview Dr. Richardson, California 626338',
                                  style: Theme.of(context).textTheme.caption),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 24),
                          child: Wrap(
                            spacing: 15,
                            children: const [
                              DropDownButtonCustom(
                                  menutItems: [], hintText: 'Shop action'),
                              DropDownButtonCustom(
                                menutItems: [],
                                hintText: 'View live',
                                iconData: Icons.language,
                              ),
                              SizedBox(width: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
                      child: Divider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: 160,
                            height: 140,
                            margin: const EdgeInsets.only(left: 25, right: 20),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.white,
                              border: Border.all(
                                color: AppColor.captionColor.withOpacity(0.15),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text('Total Sales',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption),
                                    Text(
                                      '\$5321',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                            color: AppColor.green,
                                          ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  children: <Widget>[
                                    Text('Revenue',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption),
                                    Text(
                                      '\$5321',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                            color: AppColor.green,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              'Contact',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Manager: Jerome Bell',
                                    style:
                                        Theme.of(context).textTheme.caption!),
                                Text('Info@example.com',
                                    style:
                                        Theme.of(context).textTheme.caption!),
                                Text('(255) 555-0132, (808) 555-0111',
                                    style:
                                        Theme.of(context).textTheme.caption!),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              'Address',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Country: California',
                                    style:
                                        Theme.of(context).textTheme.caption!),
                                Text('Address: Ranchview Dr.Richardson',
                                    style:
                                        Theme.of(context).textTheme.caption!),
                                Text('postal Code:  50111',
                                    style:
                                        Theme.of(context).textTheme.caption!),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            MainContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Products',
                      style: Theme.of(context).textTheme.headline4),
                  Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 14,
                        crossAxisCount: 3,
                      ),
                      padding: const EdgeInsets.all(3),
                      itemCount: 8,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductCard(
                          menuTexts: [],
                          onPressed: () {},
                          imageUrl:
                              'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MX472_AV4?wid=2000&hei=2000&fmt=jpeg&qlt=95&.v=1570119352353',
                          name: 'Apple Beats Solo3 Wireless Headphones',
                          price: 332,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
