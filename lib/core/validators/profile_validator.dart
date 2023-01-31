import 'package:reactive_forms/reactive_forms.dart';

FormGroup profile = FormGroup({
  'First Name': FormControl<String>(
    validators: [Validators.required],
  ),
  'Last Name': FormControl<String>(
    validators: [Validators.required],
  ),
  'Email': FormControl<String>(validators: [
    Validators.required,
    Validators.email,
  ]),
  'Phone Number': FormControl<String>(
    validators: [Validators.required],
  ),
  'Address': FormControl<String>(
    validators: [Validators.required],
  ),
  'Birthday': FormControl<String>(
    validators: [Validators.required],
  ),
});

Map<String, String Function(Object)>? profileValidator() {
  return {
    'required': (error) => 'The fields must not be empty',
    'email': (error) => 'Please provide a correct email',
  };
}
