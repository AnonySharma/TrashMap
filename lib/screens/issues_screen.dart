import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../widgets/issue_item.dart';
import '../models/issue.dart';

class IssuesScreen extends StatefulWidget {
  static const routeName = '/issues-screen';
  @override
  _IssuesScreenState createState() => _IssuesScreenState();
}

class _IssuesScreenState extends State<IssuesScreen> {
  List<Issue> issues= [
    Issue(id: '1', title: "Kachra saaf karo", importance: 3, imgURL: 'https://static.sciencelearn.org.nz/images/images/000/001/768/original/Recyclable-waste20160826-15827-ay9efw.jpg',location: LatLng(23.6693, 86.1511), userID: "AnonySharma"),
    Issue(id: '2', title: "Road thik karo", importance: 4, imgURL: 'https://previews.123rf.com/images/radnatt/radnatt1705/radnatt170500071/79055020-old-broken-road-in-the-village-on-sunny-summer-day.jpg', location: LatLng(25.6693, 84.1511), userID: "AnonySharma"),
    Issue(id: '1', title: "Kachra saaf karo", importance: 3, imgURL: 'https://static.sciencelearn.org.nz/images/images/000/001/768/original/Recyclable-waste20160826-15827-ay9efw.jpg',location: LatLng(23.6693, 86.1511), userID: "AnonySharma"),
    Issue(id: '2', title: "Road thik karo", importance: 4, imgURL: 'https://previews.123rf.com/images/radnatt/radnatt1705/radnatt170500071/79055020-old-broken-road-in-the-village-on-sunny-summer-day.jpg', location: LatLng(25.6693, 84.1511), userID: "AnonySharma"),
    Issue(id: '1', title: "Kachra saaf karo", importance: 3, imgURL: 'https://static.sciencelearn.org.nz/images/images/000/001/768/original/Recyclable-waste20160826-15827-ay9efw.jpg',location: LatLng(23.6693, 86.1511), userID: "AnonySharma"),
    Issue(id: '2', title: "Road thik karo", importance: 4, imgURL: 'https://previews.123rf.com/images/radnatt/radnatt1705/radnatt170500071/79055020-old-broken-road-in-the-village-on-sunny-summer-day.jpg', location: LatLng(25.6693, 84.1511), userID: "AnonySharma"),
    Issue(id: '1', title: "Kachra saaf karo", importance: 3, imgURL: 'https://static.sciencelearn.org.nz/images/images/000/001/768/original/Recyclable-waste20160826-15827-ay9efw.jpg',location: LatLng(23.6693, 86.1511), userID: "AnonySharma"),
    Issue(id: '2', title: "Road thik karo", importance: 4, imgURL: 'https://previews.123rf.com/images/radnatt/radnatt1705/radnatt170500071/79055020-old-broken-road-in-the-village-on-sunny-summer-day.jpg', location: LatLng(25.6693, 84.1511), userID: "AnonySharma"),
    Issue(id: '1', title: "Kachra saaf karo", importance: 3, imgURL: 'https://static.sciencelearn.org.nz/images/images/000/001/768/original/Recyclable-waste20160826-15827-ay9efw.jpg',location: LatLng(23.6693, 86.1511), userID: "AnonySharma"),
    Issue(id: '2', title: "Road thik karo", importance: 4, imgURL: 'https://previews.123rf.com/images/radnatt/radnatt1705/radnatt170500071/79055020-old-broken-road-in-the-village-on-sunny-summer-day.jpg', location: LatLng(25.6693, 84.1511), userID: "AnonySharma"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: issues.length,
      itemBuilder: (ctx, index) {
        return IssueItem(issues[index]);
      }
    );
  }
}