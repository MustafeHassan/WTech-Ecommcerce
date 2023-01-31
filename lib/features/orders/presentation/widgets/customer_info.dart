import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({
    Key? key,
    required this.name,
    required this.email,
    required this.phoneNumber,
  }) : super(key: key);
  final String name;
  final String email;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      children: [
        CircleAvatar(
          backgroundColor: AppColor.primaryColor.withOpacity(0.1),
          child: const Icon(Icons.person),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(name, style: Theme.of(context).textTheme.bodyText2!),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(email, style: Theme.of(context).textTheme.bodyText2!),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(phoneNumber,
                  style: Theme.of(context).textTheme.bodyText2!),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                'View profile',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppColor.primaryColor,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
