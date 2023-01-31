import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RTextFormField extends StatelessWidget {
  const RTextFormField({
    Key? key,
    required this.controllerName,
    required this.label,
    this.validationMessages,
    this.keyboardType,
    this.hintText,
    this.maxLength,
    this.prefix,
    this.maxLines,
  }) : super(key: key);
  final String controllerName;

  final int? maxLength;
  final Widget? prefix;
  final int? maxLines;
  final String label;
  final String? hintText;
  final Map<String, String Function(Object)>? validationMessages;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ReactiveTextField(
        maxLength: maxLength,
        maxLines: maxLines,
        formControlName: controllerName,
        validationMessages: validationMessages,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: prefix,
          label: Text(label),
          hintText: hintText,
        ),
      ),
    );
  }
}
