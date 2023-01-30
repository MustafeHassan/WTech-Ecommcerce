import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/theme/theme.dart';

class RPasswordTextField extends StatelessWidget {
  const RPasswordTextField({
    Key? key,
    required ValueNotifier<bool> isPasswordVisible,
    this.validationMessage,
  })  : _isPasswordVisible = isPasswordVisible,
        super(key: key);

  final ValueNotifier<bool> _isPasswordVisible;
  final Map<String, String Function(Object)>? validationMessage;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _isPasswordVisible,
        builder: (context, value, child) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: ReactiveTextField(
              validationMessages: validationMessage,
              formControlName: 'Password',
              obscureText: _isPasswordVisible.value,
              decoration: InputDecoration(
                label: const Text('Password'),
                suffixIcon: IconButton(
                  onPressed: () {
                    _isPasswordVisible.value = !_isPasswordVisible.value;
                  },
                  icon: Icon(
                    _isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: _isPasswordVisible.value
                        ? AppTheme.borderColor.withOpacity(0.3)
                        : Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
