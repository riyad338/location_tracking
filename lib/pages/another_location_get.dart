import 'dart:async';

import 'package:background_location/background_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:tracking_system/auth/auth_service.dart';
import 'package:tracking_system/pages/google_map_page.dart';
import 'package:tracking_system/pages/login_page.dart';
import 'package:tracking_system/providers/user_provider.dart';

class TrackingPage extends StatefulWidget {
  static const String routeName = '/tracking';
  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  late UserProvider _userProvider;
  @override
  void didChangeDependencies() {
    _userProvider = Provider.of<UserProvider>(context);

    super.didChangeDependencies();
  }

  final CollectionReference _carLocationCollection =
      FirebaseFirestore.instance.collection('Users');

  bool _isListeningToLocation = false;

  // void _updateCarLocation(Position position) {
  //   if (AuthService.currentUser!.uid != null) {
  //     _carLocationCollection.doc(AuthService.currentUser!.uid).set({
  //       'lat': position.latitude,
  //       'lon': position.longitude,
  //       'userCreationTime': FieldValue.serverTimestamp(),
  //     }, SetOptions(merge: true)).then((_) {
  //       print('Car location updated successfully!');
  //     }).catchError((error) {
  //       print('Error setting car location: $error');
  //     });
  //   }
  // }
  //
  // Future<void> _fetchLocation() async {
  //   try {
  //     bool serviceEnabled;
  //     LocationPermission permission;
  //
  //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       print('Location services are disabled.');
  //       return;
  //     }
  //
  //     permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         print('Location permissions are denied');
  //         return;
  //       }
  //     }
  //
  //     if (permission == LocationPermission.deniedForever) {
  //       print(
  //           'Location permissions are permanently denied, we cannot request permissions.');
  //       return;
  //     }
  //
  //     Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.best,
  //     );
  //     _updateCarLocation(position);
  //   } catch (e) {
  //     print('Error fetching location: $e');
  //   }
  // }

  @override
  void initState() {
    super.initState();

    if (AuthService.currentUser!.uid != null) {
      setState(() {
        _isListeningToLocation = true;
      });

      // _fetchLocation();
      backGroundLocation();
      // Update location every 10 seconds
      Timer.periodic(Duration(seconds: 5), (Timer timer) {
        if (_isListeningToLocation) {
          //_fetchLocation();
          backGroundLocation();
        }
      });
    }
  }

  void _updatebackground(double lat, double lon) {
    if (AuthService.currentUser!.uid != null) {
      _carLocationCollection.doc(AuthService.currentUser!.uid).set({
        'lat': lat,
        'lon': lon,
        'userCreationTime': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true)).then((_) {
        print('location updated successfully!');
      }).catchError((error) {
        print('Error setting location: $error');
      });
    }
  }

  backGroundLocation() async {
    //await BackgroundLocation.setAndroidConfiguration(1000);
    await BackgroundLocation.startLocationService(distanceFilter: 0);
    BackgroundLocation.getLocationUpdates((location) {
      setState(() {
        _updatebackground(
          double.parse(
            location.latitude.toString(),
          ),
          double.parse(
            location.longitude.toString(),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              _isListeningToLocation = false;
              await AuthService.logout().then((_) =>
                  Navigator.pushReplacementNamed(context, LoginPage.routeName));
              await _googleSignIn.signOut();
            },
            icon: Icon(Icons.logout),
          )
        ],
        title: Text('GPS Tracking'),
      ),
      body: Center(
        child: Text('You are tracked automatically.'),
      ),
    );
  }
}
