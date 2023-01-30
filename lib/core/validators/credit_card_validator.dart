import 'package:reactive_forms/reactive_forms.dart';

FormGroup creditCard = FormGroup({
  'Card Number': FormControl<String>(
    validators: [
      Validators.required,
      Validators.creditCard,
    ],
  ),
  'Card Holder': FormControl<String>(
    validators: [
      Validators.required,
      Validators.maxLength(25),
    ],
  ),
  'Month': FormControl<String>(
    validators: [Validators.required],
  ),
  'Year': FormControl<String>(
    validators: [Validators.required],
  ),
  'CVC': FormControl<String>(
    validators: [Validators.required],
  ),
});

Map<String, String Function(Object)>? creditCardValidator() {
  return {
    'required': (error) => 'The Field must not be empty',
    'maxLength': (error) => 'The holder name can not exceed 25 charecters',
    'creditCard': (error) => 'The card number must be a valid number',
  };
}
