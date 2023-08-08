import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tracking_system/auth/auth_service.dart';
import 'package:tracking_system/pages/login_page.dart';

class GoogleMapPage extends StatefulWidget {
  static const String routeName = '/map';

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(23.7458555, 90.4176781), zoom: 16);

  final CollectionReference _carLocationCollection =
      FirebaseFirestore.instance.collection('Users');

  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  // Function to get car location data from Firestore and add markers to the map
  void _getCarLocationsAndAddMarkers() {
    _carLocationCollection.snapshots().listen((snapshot) {
      setState(() {
        _markers.clear();

        for (var doc in snapshot.docs) {
          var data = doc.data() as Map<String, dynamic>?;

          if (data != null &&
              data.containsKey('lat') &&
              data.containsKey('lon')) {
            var latitude = data['lat'] as double?;
            var longitude = data['lon'] as double?;

            if (latitude != null && longitude != null) {
              var name = data['name'];
              // Create marker for each car location
              var marker = Marker(
                markerId: MarkerId(doc.id),
                position: LatLng(latitude, longitude),
                infoWindow: InfoWindow(
                  title: '$name',
                ),
              );

              _markers.add(marker);
            }
          }
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getCarLocationsAndAddMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("See all tracking location"),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService.logout().then((_) =>
                  Navigator.pushReplacementNamed(context, LoginPage.routeName));
              await _googleSignIn.signOut();
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        child: GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          initialCameraPosition: initialCameraPosition,
          markers: _markers,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
        ),
      ),
    );
  }
}
