import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tracking_system/dropdown/depend_dropdown.dart';
import 'package:tracking_system/dropdown/provider.dart';
import 'package:tracking_system/pages/another_location_get.dart';
import 'package:tracking_system/pages/countdown.dart';
import 'package:tracking_system/pages/google_map_page.dart';
import 'package:tracking_system/pages/login_page.dart';
import 'package:tracking_system/pages/launcher_page.dart';
import 'package:tracking_system/pages/phone_number_login_page.dart';
import 'package:tracking_system/providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => DropDownProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(415, 860),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: LauncherPage(),
            routes: {
              LauncherPage.routeName: (context) => LauncherPage(),
              LoginPage.routeName: (context) => LoginPage(),
              GoogleMapPage.routeName: (context) => GoogleMapPage(),
              PhoneAuthPage.routeName: (context) => PhoneAuthPage(),
              TrackingPage.routeName: (context) => TrackingPage(),
              DropDownPage.routeName: (context) => DropDownPage(),
              CountDown.routeName: (context) => CountDown(),
            },
          );
        });
  }
}
