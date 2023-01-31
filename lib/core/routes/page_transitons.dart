import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage<void> customPageBuilder({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
      position:
          Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
              .animate(animation),
      child: child,
    ),
  );
}
