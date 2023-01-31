import 'package:reactive_forms/reactive_forms.dart';

FormGroup search = FormGroup({
  'Search': FormControl<String>(
    validators: [Validators.required],
  ),
});

Map<String, String Function(Object)>? searchValidators() {
  return {
    'required': (error) => 'The search field must not be empty',
  };
}
