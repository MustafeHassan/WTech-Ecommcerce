import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:wtech_dashboard/core/routes/app_routes.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/drop_down_button.dart';
import '../../widgets/paginator.dart';
import '../../widgets/products_card.dart';

class ProductsPageTablet extends StatelessWidget {
  const ProductsPageTablet({super.key});
  static final List<String> _menuFilter = ['Category', 'Brand', 'Popularity'];
  static final List<String> _menuSort = ['First Added', 'Last Added'];
  static final List<String> _menuTexts = ['View', 'Edit', 'Delete'];
  static final List<int> _pageNumbers = List.generate(10, (index) => index);
  static final ValueNotifier<int> _currentPage = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Products Grid',
                    style: Theme.of(context).textTheme.headline4),
                Wrap(
                  spacing: 15,
                  children: [
                    const ButtonWithIcon(
                      iconData: Icons.cloud_upload,
                      text: 'Export',
                    ),
                    ButtonPrimary(
                      onPressed: () {
                        context.pushNamed(addProductScreen);
                      },
                      iconData: Icons.add,
                      text: 'Create new',
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    color: AppColor.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Search',
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Wrap(
                          spacing: 10,
                          children: [
                            DropDownButtonCustom(
                                menutItems: _menuFilter, hintText: 'Filter'),
                            DropDownButtonCustom(
                              menutItems: _menuSort,
                              hintText: 'Sort',
                              iconData: Icons.compare_arrows,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Divider(),
                  const SizedBox(height: 15),
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
                          menuTexts: _menuTexts,
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
            Paginator(
              currentPage: _currentPage,
              length: _pageNumbers.length,
              onPageChanged: (int index) {
                _currentPage.value = index;
              },
            ),
          ],
        ),
      ),
    );
  }
}
