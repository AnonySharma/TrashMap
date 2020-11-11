import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"),),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hey Dude"),
              RaisedButton(
                child: Text("Sign Out"),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    'login', (Route<dynamic> route) => false
                  );
                },
              ),
            ],
          )
        ),
      ),
    );
  }
}