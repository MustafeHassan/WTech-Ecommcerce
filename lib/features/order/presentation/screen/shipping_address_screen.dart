import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:reactive_forms/reactive_forms.dart';
import 'package:wtech_ecommerce/core/widgets/loading.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/validators/shipping_address_validator.dart';
import '../../../../core/widgets/scaffold_body.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../store/presentation/widgets/cart_icon.dart';
import '../../domain/entities/countries.dart';
import '../bloc/shipping_address/shipping_address_bloc.dart';
import '../function/shipping_address_country_and_city_selector.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({Key? key}) : super(key: key);

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final TextEditingController _addressLine2Controller = TextEditingController();
  final ValueNotifier<int> _cityIndex = ValueNotifier(0);
  final ValueNotifier<bool> _isDefaultAddress = ValueNotifier(false);

  @override
  void dispose() {
    _addressLine2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShippingAddressBloc, ShippingAddressState>(
      listener: (context, state) {
        if (state is AllShippingAddressReceivedState) {
          context.pop();
        }
      },
      builder: (context, state) {
        if (state is ShippingAddressLoading) {
          return const Loading();
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppTheme.black,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  shippingAddress.reset();
                  context.pop();
                },
                icon: const Icon(Icons.keyboard_backspace_outlined)),
            title: const Text(
              'SHIPPING ADDRESS',
            ),
            actions: [
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return CartIcon(
                    isWhiteColor: true,
                    itemCount:
                        state.cartItems.isNotEmpty ? state.cartItems.length : 0,
                    onPressed: () {},
                  );
                },
              ),
              SizedBox(width: 10.w),
            ],
          ),
          body: Column(
            children: [
              SizedBox(height: 10.h),
              Text(
                'Fill in the form below so we can know exactly\nwhere to ship your order',
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center,
              ),
              //*1 =======================================
              Expanded(
                child: ScaffoldBody(
                  lessHight: true,
                  child: ReactiveForm(
                    formGroup: shippingAddress,
                    child: ListView(
                      children: [
                        SizedBox(height: 20.h),
                        ReactiveTextField(
                          validationMessages: shippingAddressValidator(),
                          formControlName: 'Contact Name',
                          decoration: const InputDecoration(
                            label: Text('Contact Name'),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        //*1 =======================================

                        ReactiveTextField(
                          validationMessages: shippingAddressValidator(),
                          keyboardType: TextInputType.emailAddress,
                          formControlName: 'Email',
                          decoration: const InputDecoration(
                            label: Text('Email'),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        //*1 =======================================

                        ReactiveTextField(
                          validationMessages: shippingAddressValidator(),
                          formControlName: 'Phone Number',
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            label: Text('Phone Number'),
                          ),
                        ),

                        SizedBox(height: 20.h),
                        //*1 =======================================

                        ReactiveTextField(
                          validationMessages: shippingAddressValidator(),
                          formControlName: 'Address Line 1',
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
                              shippingAddress: shippingAddress,
                              cityIndex: _cityIndex,
                            );
                          },
                          formControlName: 'Country',
                          validationMessages: shippingAddressValidator(),
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
                              onTap: shippingAddress.controls['City'] == null
                                  ? null
                                  : (_) {
                                      shippingCountryAndCitySelector(
                                        context: context,
                                        countryAndCity: countiresWithCities
                                            .values
                                            .toList()[_cityIndex.value],
                                        isCountry: false,
                                        shippingAddress: shippingAddress,
                                        cityIndex: _cityIndex,
                                      );
                                    },
                              formControlName: 'City',
                              validationMessages: shippingAddressValidator(),
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
                          validationMessages: shippingAddressValidator(),
                          decoration: const InputDecoration(
                            label: Text('Zib Code'),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        //*1 =======================================

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Set Default Address',
                                style: Theme.of(context).textTheme.bodyText1),
                            ValueListenableBuilder(
                              valueListenable: _isDefaultAddress,
                              builder: (BuildContext context, bool value,
                                  Widget? child) {
                                return CupertinoSwitch(
                                  activeColor: AppTheme.primaryColor,
                                  value: value,
                                  onChanged: (_) {
                                    _isDefaultAddress.value =
                                        !_isDefaultAddress.value;
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        //*1 =======================================

                        ReactiveFormConsumer(
                          builder: (context, formGroup, child) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: formGroup.valid
                                    ? () {
                                        context.read<ShippingAddressBloc>().add(
                                              ShippingAddressSet(
                                                contactName: formGroup
                                                    .value['Contact Name']
                                                    .toString(),
                                                email: formGroup.value['Email']
                                                    .toString(),
                                                phoneNumber: formGroup
                                                    .value['Phone Number']
                                                    .toString(),
                                                addressLine1: formGroup
                                                    .value['Address Line 1']
                                                    .toString(),
                                                addressLine2:
                                                    _addressLine2Controller
                                                        .text,
                                                country: formGroup
                                                    .value['Country']
                                                    .toString(),
                                                city: formGroup.value['City']
                                                    .toString(),
                                                zipCode: int.parse(
                                                  formGroup.value['Zib Code']
                                                      .toString(),
                                                ),
                                                isDefault:
                                                    _isDefaultAddress.value,
                                              ),
                                            );
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
              ),
            ],
          ),
        );
      },
    );
  }
}
