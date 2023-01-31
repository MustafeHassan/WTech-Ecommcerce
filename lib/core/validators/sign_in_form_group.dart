import 'package:reactive_forms/reactive_forms.dart';

FormGroup logInGroup = FormGroup(
  {
    'Email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'Password': FormControl<String>(
      validators: [
        Validators.required,
      ],
      touched: false,
    ),
  },
);

//*  Fomr Validators Messages

Map<String, String Function(Object)>? emailValidator() {
  return {
    'required': (error) => 'The email must not be empty',
    'email': (error) => 'The email must be a valid email',
  };
}

Map<String, String Function(Object)>? passwordValidator() {
  return {
    'required': (error) => 'The password must not be empty',
  };
}
