import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignInOrSignUpButtonConsumer extends StatelessWidget {
  const SignInOrSignUpButtonConsumer({
    Key? key,
    required this.signInOrSignUp,
    required this.text,
  }) : super(key: key);
  final VoidCallback signInOrSignUp;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, formGroup, _) {
        return ElevatedButton(
          onPressed: formGroup.valid ? signInOrSignUp : null,
          child: Text(
            text,
            style: Theme.of(context).textTheme.button,
          ),
        );
      },
    );
  }
}
