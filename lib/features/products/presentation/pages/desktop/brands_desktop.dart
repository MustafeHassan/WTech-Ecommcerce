import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:wtech_dashboard/core/validators/search_validator.dart';
import 'package:wtech_dashboard/core/widgets/button.dart';
import 'package:wtech_dashboard/core/widgets/drop_down_button.dart';
import 'package:wtech_dashboard/core/widgets/main_container.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/widgets/r_text_field.dart';
import '../../widgets/brand_viewr.dart';
import '../../widgets/paginator.dart';

class BrandsScreenDesktop extends StatelessWidget {
  const BrandsScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Text('Brands', style: Theme.of(context).textTheme.headline4),
                const Spacer(),
                ButtonPrimary(
                  text: 'Create New',
                  onPressed: () {},
                  iconData: Icons.add,
                ),
              ],
            ),
            MainContainer(
              height: MediaQuery.of(context).size.height * 0.8,
              addPadding: false,
              child: ReactiveForm(
                formGroup: search,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: RTextFormField(
                              controllerName: 'Search',
                              label: 'Search',
                              validationMessages: searchValidators(),
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 24.0, right: 14),
                          child: DropDownButtonCustom(
                            width: 88,
                            menutItems: ['Last Added', 'First Added'],
                            hintText: 'Date',
                            iconData: Icons.compare_arrows,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: 12,
                        itemBuilder: (BuildContext context, int index) {
                          return const BrandsViewer();
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Paginator(
                      currentPage: ValueNotifier(0),
                      length: 5,
                      onPageChanged: (int index) {
                        ValueNotifier(index).value = index;
                      },
                    ),
                    const SizedBox(height: 20),
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
