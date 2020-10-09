import 'package:flutter/material.dart';

class MapsScreen extends StatefulWidget {
  static const routeName = '/maps-screen';
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Maps Screen"),
            Container(
              height: 500,
              width: double.infinity,
              color: Colors.grey,
              child: Center(
                child: Text("Local Map", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30))
              ),
            )
          ],
        ),
      ),
    );
  }
}