import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';

class Issue {
  final String id;
  final String title;
  final String imgURL;
  final int importance;
  final LatLng location;
  final String userID;
  final bool isResolved;

  Issue({@required this.id, @required this.title, @required this.imgURL, @required this.importance, @required this.location, @required this.userID, this.isResolved=false});
}