import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trash_map/authentication_service.dart';
import 'package:trash_map/screens/issue_detail_screen.dart';
import './screens/home_screen.dart';
import './screens/issues_screen.dart';
import './screens/maps_screen.dart';
import './screens/notification_screen.dart';
import './screens/profile_screen.dart';
import './screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance), 
        ),

        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
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
          IssueDetailScreen.routeName: (_) => IssueDetailScreen(),
        },
      ),
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
    final firebaseUser = context.watch<User>();

    if(firebaseUser == null)
      return LoginScreen();
    else
      return HomeScreen();
  }
}