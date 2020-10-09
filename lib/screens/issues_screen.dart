import 'package:flutter/material.dart';

class IssuesScreen extends StatefulWidget {
  static const routeName = '/issues-screen';
  @override
  _IssuesScreenState createState() => _IssuesScreenState();
}

class _IssuesScreenState extends State<IssuesScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("Nearby Issues"),
      ),
    );
  }
}