import 'package:flutter/material.dart';

class Responsiveness extends StatelessWidget {
  const Responsiveness({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  static bool isMobile(BuildContext context) {
    if (MediaQuery.of(context).size.width <= 480) {
      return true;
    }
    return false;
  }

  static bool isTablet(BuildContext context) {
    if ((MediaQuery.of(context).size.width > 480) &&
        (MediaQuery.of(context).size.width < 1024)) {
      return true;
    }
    return false;
  }

  static bool isDesktop(BuildContext context) {
    if (MediaQuery.of(context).size.width >= 1024) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        if (constraint.maxWidth <= 480) {
          return mobile;
        } else if ((constraint.maxWidth > 480) &&
            (constraint.maxWidth < 1024)) {
          return tablet;
        } else {
          return desktop;
        }
      },
    );
  }
}
