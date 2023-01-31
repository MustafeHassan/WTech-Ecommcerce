import 'package:reactive_forms/reactive_forms.dart';

FormGroup categoriesForm = FormGroup(
  {
    'Name': FormControl<String>(
      validators: [Validators.required],
    ),
    'Description': FormControl<String>(
      validators: [
        Validators.required,
      ],
      touched: false,
    ),
  },
);

//*  Fomr Validators Messages

Map<String, String Function(Object)>? categoriesValidator() {
  return {
    'required': (error) => 'The field must not be empty',
  };
}
