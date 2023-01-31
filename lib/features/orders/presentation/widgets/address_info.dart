import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class AddressInfo extends StatelessWidget {
  const AddressInfo({
    Key? key,
    required this.icon,
    required this.title,
    required this.city,
    required this.street,
    required this.address,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final String city;
  final String street;
  final String address;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      children: [
        CircleAvatar(
          backgroundColor: AppColor.primaryColor.withOpacity(0.1),
          child: const Icon(Icons.location_on_rounded),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text.rich(
                TextSpan(
                  text: 'City: ',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppColor.captionColor.withOpacity(0.6),
                      ),
                  children: [
                    TextSpan(
                      text: city,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text.rich(
                TextSpan(
                  text: 'Street: ',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppColor.captionColor.withOpacity(0.6),
                      ),
                  children: [
                    TextSpan(
                      text: street,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text.rich(
                TextSpan(
                  text: 'Address: ',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppColor.captionColor.withOpacity(0.6),
                      ),
                  children: [
                    TextSpan(
                      text: address,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Open Map',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: AppColor.primaryColor,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
