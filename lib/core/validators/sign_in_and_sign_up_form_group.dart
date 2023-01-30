import 'package:reactive_forms/reactive_forms.dart';

FormGroup signUpGroup = FormGroup(
  {
    'Username': FormControl<String>(
      validators: [Validators.required],
    ),
    'Email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'Password': FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(8),
        Validators.pattern(
            r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$")
      ],
      touched: false,
    ),
    'Phone': FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(12),
      ],
    ),
  },
);

FormGroup signInGroup = FormGroup(
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
Map<String, String Function(Object)>? userNameValidator() {
  return {
    'required': (error) => 'The username must not be empty',
  };
}

Map<String, String Function(Object)>? emailValidator() {
  return {
    'required': (error) => 'The email must not be empty',
    'email': (error) => 'The email must be a valid email',
  };
}

Map<String, String Function(Object)>? passwordValidator() {
  return {
    'required': (error) => 'The password must not be empty',
    'minLength': (error) => 'The password must be at least 8 characters',
    'pattern': (error) =>
        'The password must contain at least a lowercase\n, an uppercase letter, a number and a symbol',
  };
}

Map<String, String Function(Object)>? signInPasswordValidator() {
  return {
    'required': (error) => 'The password must not be empty',
  };
}

Map<String, String Function(Object)>? phoneValidator() {
  return {
    'required': (error) => 'The phone number must not be empty',
    'minLength': (error) => 'The phone number must at 15 digits',
  };
}
