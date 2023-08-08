import 'package:flutter/material.dart';
import 'package:tracking_system/pages/login_page.dart';

import '../auth/auth_service.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName = '/launcher';
  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (AuthService.currentUser == null) {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      } else {
        AuthService.roleBaseLogin(context);
        // Navigator.pushReplacementNamed(context, ProductListPage.routeName);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CircularProgressIndicator(
        color: Colors.greenAccent,
      )),
    );
  }
}
