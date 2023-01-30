import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:reactive_forms/reactive_forms.dart';
import 'package:wtech_ecommerce/core/widgets/loading.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/validators/card_formatter.dart';
import '../../../../core/validators/credit_card_validator.dart';
import '../../../../core/widgets/credit_card.dart';
import '../../../../core/widgets/scaffold_body.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../store/presentation/widgets/cart_icon.dart';
import '../bloc/credit_cards/credit_cards_bloc.dart';
import '../function/date_time_picker.dart';

class PaymentDetailScreen extends StatefulWidget {
  const PaymentDetailScreen({Key? key}) : super(key: key);

  @override
  State<PaymentDetailScreen> createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {
  final String _emptyCardNumber = '---- ---- ---- ----';
  String _expireDate = '-- / --';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreditCardsBloc, CreditCardsState>(
      listener: (context, state) {
        if (state is AllCreditCardsReceivedState) {
          context.pop();
        }
      },
      builder: (context, state) {
        if (state is CreditCardsLoading) {
          return const Loading();
        }
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
            title: const Text(
              'PAYMENT DETAIL',
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
          body: ReactiveForm(
            formGroup: creditCard,
            child: Column(
              children: [
                SizedBox(
                  // height: 240.h,
                  width: 330.w,
                  child: Column(
                    children: [
                      SizedBox(height: 15.h),
                      CreditCards(
                        isPaymentDetail: true,
                        cardDate: _expireDate,
                        cardHolder:
                            creditCard.controls['Card Holder']?.value == null
                                ? 'Card Holder'
                                : creditCard.controls['Card Holder']!.value
                                    .toString(),
                        cardNumber:
                            creditCard.controls['Card Number']?.value == null
                                ? _emptyCardNumber
                                : creditCard.controls['Card Number']!.value
                                    .toString(),
                      ),
                    ],
                  ),
                ),
                Expanded(
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
                            onChanged: (_) {
                              setState(() {
                                creditCard.controls['Card Number']?.updateValue(
                                  creditCard.controls['Card Number']!.value
                                      .toString(),
                                );
                              });
                            },
                            decoration: const InputDecoration(
                              label: Text('Card Number'),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          ReactiveTextField(
                            validationMessages: creditCardValidator(),
                            formControlName: 'Card Holder',
                            onChanged: (_) {
                              setState(() {});
                            },
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
                                          ? control
                                              .updateValue('${month.month}')
                                          : control
                                              .updateValue('0${month.month}');

                                      if (creditCard.controls['Year']?.value !=
                                          null) {
                                        _expireDate =
                                            '${control.value}/${creditCard.controls['Year']!.value.toString()}';
                                        setState(() {});
                                      }
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
                                          null) {
                                        _expireDate =
                                            '${creditCard.controls['Month']!.value.toString()}/${control.value}';
                                        setState(() {});
                                      }
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
                            onChanged: (_) {
                              setState(() {});
                            },
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
                                    }
                                  : null,
                              child: Text(
                                'CONFIRM PAYMENT ',
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
      },
    );
  }
}
