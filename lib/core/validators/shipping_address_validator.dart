import 'package:reactive_forms/reactive_forms.dart';

FormGroup shippingAddress = FormGroup({
  'Contact Name': FormControl<String>(
    validators: [Validators.required],
  ),
  'Email': FormControl<String>(
    validators: [Validators.required, Validators.email],
  ),
  'Phone Number': FormControl<String>(
    validators: [Validators.required, Validators.number],
  ),
  'Address Line 1': FormControl<String>(
    validators: [Validators.required],
  ),
  'Country': FormControl<String>(
    validators: [Validators.required],
  ),
  'City': FormControl<String>(
    validators: [Validators.required],
  ),
  'Zib Code': FormControl<String>(
    validators: [Validators.required],
  ),
});
FormGroup changeAddress = FormGroup({
  'Address Line 1': FormControl<String>(
    validators: [Validators.required],
  ),
  'Country': FormControl<String>(
    validators: [Validators.required],
  ),
  'City': FormControl<String>(
    validators: [Validators.required],
  ),
  'Zib Code': FormControl<String>(
    validators: [Validators.required],
  ),
});

Map<String, String Function(Object)>? changeAddressValidator() {
  return {
    'required': (error) => 'This field must not be empty',
  };
}

Map<String, String Function(Object)>? shippingAddressValidator() {
  return {
    'required': (error) => 'This field must not be empty',
    'email': (error) => 'The email must be a valid one',
    'number': (error) => 'The number must be a valid one '
  };
}
