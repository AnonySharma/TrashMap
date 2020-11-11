import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';

class Issue {
  final String id;
  final String title;
  final String desc;
  final String location;
  final String imgURL;
  final int importance;
  final LatLng coord;
  final String userID;
  final bool isResolved;

  Issue({@required this.id, @required this.title, this.desc="Not Available", @required this.imgURL, @required this.importance, @required this.coord, @required this.location, @required this.userID, this.isResolved=false});
}