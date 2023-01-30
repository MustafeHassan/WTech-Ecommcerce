import 'package:flutter/material.dart';

class OptCodeResender extends StatelessWidget {
  const OptCodeResender({
    Key? key,
    required ValueNotifier<bool> isInitialTimeDone,
    required this.onPressed,
  })  : _isInitialTimeDone = isInitialTimeDone,
        super(key: key);
  final VoidCallback onPressed;
  final ValueNotifier<bool> _isInitialTimeDone;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isInitialTimeDone,
      builder: (BuildContext context, bool value, Widget? child) {
        return ElevatedButton(
          onPressed: value ? onPressed : null,
          child: Text(
            'REQUEST NEW CODE',
            style: Theme.of(context).textTheme.button,
          ),
        );
      },
    );
  }
}
