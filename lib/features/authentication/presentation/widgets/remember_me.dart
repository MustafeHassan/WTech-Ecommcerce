import 'package:flutter/material.dart';

import 'package:wtech_dashboard/core/theme/colors.dart';

class RememberMeWithForgotPassword extends StatelessWidget {
  const RememberMeWithForgotPassword({
    Key? key,
    required ValueNotifier<bool> rememberMeStatus,
    this.onPressed,
  })  : _rememberMeStatus = rememberMeStatus,
        super(key: key);
  final VoidCallback? onPressed;
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
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
          TextButton(
            onPressed: onPressed,
            child: Text(
              'Forgot Password?',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
