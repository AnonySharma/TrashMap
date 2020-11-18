import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trash_map/models/issue.dart';
import 'package:trash_map/widgets/issue_item.dart';

class IssuesScreen extends StatefulWidget {
  @override
  _IssuesScreenState createState() => _IssuesScreenState();
}

class _IssuesScreenState extends State<IssuesScreen> {
  List<Issue> issues = [];
  getIssues() async {
    CollectionReference snapshot = FirebaseFirestore.instance.collection('issues');
    // print(snapshot);
    snapshot.snapshots().listen((event) {
      setState(() {
        issues.clear();
        event.docs.forEach((el) {
          var tmp=el.data();
          print(el.id+tmp.toString());
          issues.add(Issue(id: el.id, title: tmp['title'], imgURL: tmp['img'], desc: tmp['desc'], importance: tmp['imp'], coord: LatLng(tmp['coord'].latitude, tmp['coord'].longitude), location: tmp['loc'], userID: tmp['createdBy']));
        });
      });
    });
    print(issues);
  }

  @override
  void initState() {
    setState(() {
      getIssues();
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return issues.length==0
    ? Container(
      child: Center(
        child: Text(
          "No Issues yet!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    )
    : ListView.builder(
      itemCount: issues.length,
      itemBuilder: (ctx, index) {
        return IssueItem(issues[index]);
      }
    );
  }
}