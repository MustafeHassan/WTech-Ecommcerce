import 'package:reactive_forms/reactive_forms.dart';

FormGroup forgotPassword = FormGroup({
  'Email': FormControl<String>(
    validators: [Validators.required, Validators.email],
  ),
});

Map<String, String Function(Object)>? emailValidator() {
  return {
    'required': (error) => 'The email must not be empty',
    'email': (error) => 'The email must be a valid email',
  };
}
