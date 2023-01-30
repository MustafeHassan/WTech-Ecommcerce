// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:reactive_forms/reactive_forms.dart';
import 'package:wtech_ecommerce/core/theme/app_icons.dart';
import 'package:wtech_ecommerce/core/widgets/loading.dart';
import 'package:wtech_ecommerce/features/order/domain/entities/credit_card_entity.dart';
import 'package:wtech_ecommerce/features/order/presentation/bloc/credit_cards/credit_cards_bloc.dart';
import 'package:wtech_ecommerce/features/order/presentation/function/date_time_picker.dart';
import 'package:wtech_ecommerce/features/settings/presentation/function/functions.dart';
import 'package:wtech_ecommerce/features/store/presentation/widgets/icon_box.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/validators/card_formatter.dart';
import '../../../../core/validators/credit_card_validator.dart';
import '../../../../core/widgets/credit_card.dart';
import '../../../../core/widgets/scaffold_body.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../store/presentation/widgets/cart_icon.dart';
import 'package:wtech_ecommerce/services_locator.dart' as di;

class CreditCardsScreen extends StatefulWidget {
  const CreditCardsScreen({Key? key}) : super(key: key);

  @override
  State<CreditCardsScreen> createState() => _CreditCardsScreenState();
}

class _CreditCardsScreenState extends State<CreditCardsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CreditCardsBloc>().add(AllCreditCardsRequested());
  }

  static final ValueNotifier<bool> _isRemoveEnabled = ValueNotifier(false);

  List<CreditCardE> cards = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreditCardsBloc, CreditCardsState>(
        listener: (context, state) {
      if (state is AllCreditCardsReceivedState) {
        cards = context.read<CreditCardsBloc>().creditCards;
        // context.pop();
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.keyboard_backspace,
              color: AppTheme.white,
            ),
          ),
          title: Text(
            'MY CARDS (${cards.length})',
          ),
          actions: [
            IconButton(
              onPressed: () {
                _isRemoveEnabled.value = !_isRemoveEnabled.value;
              },
              icon: Icon(
                CupertinoIcons.trash,
                color: AppTheme.white,
              ),
            ),
            SizedBox(width: 10.w),
          ],
        ),
        body: ReactiveForm(
          formGroup: creditCard,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cards.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 230.h,
                      width: MediaQuery.of(context).size.width,
                      child: ValueListenableBuilder(
                        valueListenable: _isRemoveEnabled,
                        builder:
                            (BuildContext context, bool value, Widget? child) {
                          return Stack(
                            children: [
                              CreditCards(
                                cardDate: cards[index].cardExpireDate,
                                cardHolder: cards[index].cardHolder,
                                cardNumber: cards[index].cardNumber,
                              ),
                              Visibility(
                                visible: value,
                                child: Positioned(
                                  top: 5,
                                  right: 10,
                                  child: IconBox(
                                    scale: 0.44,
                                    onTap: () async {
                                      var user = jsonDecode(
                                          di.preferences.getString('user')!);
                                      if (value) {
                                        var isDeleted = await deleteCreditCards(
                                          uid: user['id'],
                                          cardNumber: cards[index].cardNumber,
                                        );
                                        if (isDeleted) {
                                          context
                                              .read<CreditCardsBloc>()
                                              .add(AllCreditCardsRequested());

                                          setState(() {});
                                        }
                                      }
                                    },
                                    iconPath: AppIcons.trash,
                                    boxColor: AppTheme.red,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: ScaffoldBody(
                  lessHight: true,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 30.h),
                        ReactiveTextField(
                          validationMessages: creditCardValidator(),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CardNumberFormatter()
                          ],
                          formControlName: 'Card Number',
                          decoration: const InputDecoration(
                            label: Text('Card Number'),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        ReactiveTextField(
                          validationMessages: creditCardValidator(),
                          formControlName: 'Card Holder',
                          decoration: const InputDecoration(
                            label: Text('Cardholder Name'),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          children: [
                            Expanded(
                              child: ReactiveTextField(
                                validationMessages: {
                                  'required': (error) => 'Choose a month',
                                },
                                formControlName: 'Month',
                                readOnly: true,
                                onTap: (control) async {
                                  //* control is for month field
                                  var month =
                                      await showDateAndTime(context, false);
                                  if (month != null) {
                                    month.month > 9
                                        ? control.updateValue('${month.month}')
                                        : control
                                            .updateValue('0${month.month}');

                                    if (creditCard.controls['Year']?.value !=
                                        null) {}
                                  }
                                },
                                decoration: const InputDecoration(
                                  suffixIcon:
                                      Icon(Icons.arrow_forward_ios_rounded),
                                  label: Text('Month'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ReactiveTextField(
                                validationMessages: {
                                  'required': (error) => 'Choose a year',
                                },
                                formControlName: 'Year',
                                readOnly: true,
                                onTap: (control) async {
                                  //* controll is for year field
                                  var year =
                                      await showDateAndTime(context, true);
                                  if (year != null) {
                                    control.updateValue('${year.year}');
                                    control.value.toString();
                                    if (creditCard.controls['Month']?.value !=
                                        null) {}
                                  }
                                },
                                decoration: const InputDecoration(
                                  suffixIcon:
                                      Icon(Icons.arrow_forward_ios_rounded),
                                  label: Text('Year'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        ReactiveTextField(
                          validationMessages: creditCardValidator(),
                          formControlName: 'CVC',
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            label: Text('CVC'),
                          ),
                        ),
                        SizedBox(height: 90.h),
                        ReactiveFormConsumer(
                            builder: (context, formGroup, child) {
                          return ElevatedButton(
                            onPressed: formGroup.valid
                                ? () {
                                    context.read<CreditCardsBloc>().add(
                                          PaymentMethodSet(
                                            cardHolder: formGroup
                                                .value['Card Holder']
                                                .toString(),
                                            cardNumber: formGroup
                                                .value['Card Number']
                                                .toString(),
                                            cardExpireDate:
                                                '${formGroup.value['Month']}/${formGroup.value['Year']}',
                                            cvc: int.parse(
                                              (formGroup.value['CVC']
                                                  as String),
                                            ),
                                          ),
                                        );
                                    formGroup.reset();
                                  }
                                : null,
                            child: Text(
                              'ADD CARD',
                              style: Theme.of(context).textTheme.button,
                            ),
                          );
                        }),
                        SizedBox(height: 5.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
