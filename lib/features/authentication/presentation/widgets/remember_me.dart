import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_route.dart';

class RememberMeWithForgotPassword extends StatelessWidget {
  const RememberMeWithForgotPassword({
    Key? key,
    required ValueNotifier<bool> rememberMeStatus,
  })  : _rememberMeStatus = rememberMeStatus,
        super(key: key);

  final ValueNotifier<bool> _rememberMeStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Transform.scale(
                scale: 1.2,
                child: ValueListenableBuilder(
                    valueListenable: _rememberMeStatus,
                    builder: (context, value, _) {
                      return Checkbox(
                        value: _rememberMeStatus.value,
                        onChanged: (_) async {
                          _rememberMeStatus.value = !_rememberMeStatus.value;
                        },
                      );
                    }),
              ),
              Text('Remember Me', style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
          //* 4 -------------------------------------------

          TextButton(
            onPressed: () {
              context.pushNamed(forgotPasswordScreen);
            },
            child: Text('Forgot Password?',
                style: Theme.of(context).textTheme.bodyText1),
          ),
        ],
      ),
    );
  }
}
