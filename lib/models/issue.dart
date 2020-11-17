import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';

class Issue {
  final String id;
  final String title;
  String desc;
  final String location;
  final String imgURL;
  final int importance;
  final LatLng coord;
  final String userID;
  bool isResolved;
  int upvotes;
  int downvotes;

  Issue({
    @required this.id, 
    @required this.title, 
    @required this.imgURL, 
    @required this.importance, 
    @required this.coord, 
    @required this.location, 
    @required this.userID, 
    this.desc="Not Available", 
    this.isResolved=false, 
    this.upvotes=0, 
    this.downvotes=0
  });
}