import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  }) : super(key: key);
  final String controllerName;
  final int? maxLength;
  final String label;
  final String? hintText;
  final Map<String, String Function(Object)>? validationMessages;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: ReactiveTextField(
        maxLength: maxLength,
        formControlName: controllerName,
        validationMessages: validationMessages,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          label: Text(label),
          hintText: hintText,
        ),
      ),
    );
  }
}
