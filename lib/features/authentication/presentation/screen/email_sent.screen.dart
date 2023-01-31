import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:wtech_dashboard/core/routes/app_routes.dart';

import '../../../../core/theme/assets_names.dart';

class EmailSentScreen extends StatelessWidget {
  const EmailSentScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Lottie.asset(
                emailSent,
                width: 180,
                height: 180,
                repeat: true,
              ),
              const SizedBox(height: 15),
              Text('Check Your Email',
                  style: Theme.of(context).textTheme.headline2),
              Text(
                'We\'ve sent you an instructions on how to reset password  your to mail address \n check your inbox or spam folder',
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  context.goNamed(loginScreen);
                },
                child: Text('CONTINUE'.toUpperCase(),
                    style: Theme.of(context).textTheme.button),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
