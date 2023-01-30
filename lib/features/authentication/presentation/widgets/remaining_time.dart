import 'package:flutter/material.dart';

class RemainingTime extends StatelessWidget {
  const RemainingTime({
    Key? key,
    required ValueNotifier<int> initialTime,
  })  : _initialTime = initialTime,
        super(key: key);

  final ValueNotifier<int> _initialTime;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _initialTime,
      builder: (BuildContext context, int value, Widget? child) {
        return Text(
          value < 10
              ? 'Request new code in 00:0$value'
              : 'Request new code in 00:$value',
          style: Theme.of(context).textTheme.bodyText1,
        );
      },
    );
  }
}
