import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:reactive_forms/reactive_forms.dart';
import 'package:wtech_ecommerce/features/order/domain/entities/countries.dart';

import 'package:wtech_ecommerce/features/order/presentation/function/shipping_address_country_and_city_selector.dart';
import 'package:wtech_ecommerce/services_locator.dart' as di;

import '../../../../core/theme/theme.dart';
import '../../../../core/validators/shipping_address_validator.dart';
import '../../../../core/widgets/scaffold_body.dart';
import '../function/functions.dart';

class ChangeAddressScreen extends StatefulWidget {
  const ChangeAddressScreen({Key? key, this.addressToChange}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final addressToChange;

  @override
  State<ChangeAddressScreen> createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
  final TextEditingController _addressLine2Controller = TextEditingController();
  final ValueNotifier<int> _cityIndex = ValueNotifier(0);
  var user =
      jsonDecode(di.preferences.getString('user')!) as Map<String, dynamic>;

  @override
  void dispose() {
    _addressLine2Controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    changeAddress.controls['Address Line 1']?.updateValue(
        widget.addressToChange['addressContent']['address line 1']);
    _addressLine2Controller.text =
        widget.addressToChange['addressContent']['address line 2'];
    changeAddress.controls['Country']
        ?.updateValue(widget.addressToChange['addressContent']['country']);
    changeAddress.controls['City']
        ?.updateValue(widget.addressToChange['addressContent']['city']);
    changeAddress.controls['Zib Code']?.updateValue(
        widget.addressToChange['addressContent']['zipCode'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            changeAddress.reset();
            context.pop();
          },
          icon: const Icon(Icons.keyboard_backspace_outlined),
        ),
        title: Text(
          (widget.addressToChange['addressType'] == 'home' ||
                  widget.addressToChange['addressType'] == 'shippingAddress')
              ? 'CHANGE ADDRESS'
              : 'NEW ADDRESS',
        ),
      ),
      body: ScaffoldBody(
        child: ReactiveForm(
          formGroup: changeAddress,
          child: ListView(
            children: [
              SizedBox(height: 20.h),
              //*1 =======================================

              ReactiveTextField(
                validationMessages: changeAddressValidator(),
                formControlName: 'Address Line 1',
                onChanged: (control) {},
                decoration: const InputDecoration(
                  label: Text('Address Line 1'),
                ),
              ),
              SizedBox(height: 25.h),
              //*1 =======================================

              const TextField(
                decoration: InputDecoration(
                  label: Text('Address Line 2'),
                ),
              ),
              SizedBox(height: 25.h),
              //*1 =======================================

              ReactiveTextField(
                readOnly: true,
                onTap: (_) {
                  shippingCountryAndCitySelector(
                    context: context,
                    countryAndCity: countiresWithCities.keys.toList(),
                    isCountry: true,
                    shippingAddress: changeAddress,
                    cityIndex: _cityIndex,
                  );
                },
                formControlName: 'Country',
                validationMessages: changeAddressValidator(),
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.arrow_forward_ios_sharp),
                  label: Text(
                    'Country',
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              //*1 =======================================

              ValueListenableBuilder(
                valueListenable: _cityIndex,
                builder: (context, value, child) {
                  return ReactiveTextField(
                    readOnly: true,
                    onTap: changeAddress.controls['City'] == null
                        ? null
                        : (_) {
                            shippingCountryAndCitySelector(
                              context: context,
                              countryAndCity: countiresWithCities.values
                                  .toList()[_cityIndex.value],
                              isCountry: false,
                              shippingAddress: changeAddress,
                              cityIndex: _cityIndex,
                            );
                          },
                    formControlName: 'City',
                    validationMessages: changeAddressValidator(),
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.arrow_forward_ios_sharp),
                      label: Text(
                        'City',
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 40.h),
              //*1 =======================================

              ReactiveTextField(
                keyboardType: TextInputType.number,
                formControlName: 'Zib Code',
                validationMessages: changeAddressValidator(),
                decoration: const InputDecoration(
                  label: Text('Zib Code'),
                ),
              ),

              SizedBox(height: 40.h),
              //*1 =======================================

              ReactiveFormConsumer(
                builder: (context, formGroup, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: formGroup.valid
                          ? () async {
                              await updateAddress(
                                uid: user['id'],
                                addressLine1: formGroup.value['Address Line 1']
                                    .toString(),
                                addressLine2: _addressLine2Controller.text,
                                country: formGroup.value['Country'].toString(),
                                city: formGroup.value['City'].toString(),
                                zipCode: int.parse(
                                  formGroup.value['Zib Code'].toString(),
                                ),
                                isDefault:
                                    widget.addressToChange['addressType'] ==
                                        'home',
                              );
                              // ignore: use_build_context_synchronously
                              context.pop();
                              context.pop();
                            }
                          : null,
                      child: Text(
                        'SET ADDRESS',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
