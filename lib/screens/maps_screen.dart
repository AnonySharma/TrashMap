import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  static const routeName = '/maps-screen';
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  GoogleMapController mapController;
  LatLng _center;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _center = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void initState() {
    _getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
        target: _center==null?LatLng(23.6693, 86.1511):_center,
        zoom: 10.0,
      ),
    );
  }
}