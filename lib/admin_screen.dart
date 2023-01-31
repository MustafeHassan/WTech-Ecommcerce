import 'package:flutter/material.dart';

import 'package:wtech_dashboard/responsiveness.dart';

import 'core/widgets/appBar_builder.dart';
import 'core/widgets/drawer.dart';
import 'core/widgets/side_menu.dart';

class ShellAdminScree extends StatelessWidget {
  const ShellAdminScree({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const MyDrawer(),
      appBar: topBar(context, scaffoldKey),
      body: Row(
        children: [
          Visibility(
            visible: Responsiveness.isDesktop(context),
            child: const Expanded(
              flex: 2,
              child: SideMenu(),
            ),
          ),
          Expanded(flex: 8, child: child),
        ],
      ),
    );
  }
}
