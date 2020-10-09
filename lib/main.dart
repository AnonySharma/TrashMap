import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/issues_screen.dart';
import './screens/maps_screen.dart';
import './screens/notification_screen.dart';
import './screens/profile_screen.dart';
import './screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrashMap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      routes: {
        // '/': (_) => MyHomePage(),
        'login': (_) => MyHomePage(),
        LoginScreen.routeName: (_) => LoginScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        ProfileScreen.routeName: (_) => ProfileScreen(),
        IssuesScreen.routeName: (_) => IssuesScreen(),
        MapsScreen.routeName: (_) => MapsScreen(),
        NotificationScreen.routeName: (_) => NotificationScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    AppBar myAppBar = AppBar(title: Text("TrashMap"),);

    return Scaffold(
      appBar: myAppBar,
      body: LoginScreen(),
    );
  }
}
