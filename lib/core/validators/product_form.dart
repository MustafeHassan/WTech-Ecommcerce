import 'package:reactive_forms/reactive_forms.dart';

FormGroup productForm = FormGroup(
  {
    'Name': FormControl<String>(
      validators: [Validators.required],
    ),
    'Color': FormControl<String>(
      validators: [
        Validators.required,
      ],
      touched: false,
    ),
    'Full Description': FormControl<String>(
      validators: [
        Validators.required,
      ],
      touched: false,
    ),
    'Specification - 1': FormControl<String>(
      validators: [
        Validators.required,
      ],
      touched: false,
    ),
    'Value - 1': FormControl<String>(
      validators: [
        Validators.required,
      ],
      touched: false,
    ),
    'Specification - 2': FormControl<String>(
      validators: [
        Validators.required,
      ],
      touched: false,
    ),
    'Value - 2': FormControl<String>(
      validators: [
        Validators.required,
      ],
      touched: false,
    ),
    'Specification - 3': FormControl<String>(
      validators: [
        Validators.required,
      ],
      touched: false,
    ),
    'Value - 3': FormControl<String>(
      validators: [
        Validators.required,
      ],
      touched: false,
    ),
    'Specification - 4': FormControl<String>(
      validators: [
        Validators.required,
      ],
      touched: false,
    ),
    'Value - 4': FormControl<String>(
      validators: [
        Validators.required,
      ],
      touched: false,
    ),
    'Brand': FormControl<String>(
      validators: [Validators.required],
    ),
    'Price': FormControl<String>(
      validators: [Validators.required, Validators.number],
    ),
  },
);

//*  Fomr Validators Messages

Map<String, String Function(Object)>? productFormValidator() {
  return {
    'required': (error) => 'The field must not be empty',
    'number': (error) => 'must enter a valid number',
  };
}
