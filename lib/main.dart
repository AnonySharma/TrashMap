import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trash_map/screens/add_issue.dart';
import './screens/about_screen.dart';
import './screens/contact_screen.dart';
import './authentication_service.dart';
import './screens/issue_detail_screen.dart';
import './screens/home_screen.dart';
import './screens/issues_screen.dart';
import './screens/signup_screen.dart';
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
          SignUpScreen.routeName: (_) => SignUpScreen(),
          HomeScreen.routeName: (_) => HomeScreen(),
          ProfileScreen.routeName: (_) => ProfileScreen(),
          IssuesScreen.routeName: (_) => IssuesScreen(),
          MapsScreen.routeName: (_) => MapsScreen(),
          NotificationScreen.routeName: (_) => NotificationScreen(),
          IssueDetailScreen.routeName: (_) => IssueDetailScreen(),
          AboutScreen.routeName: (_) => AboutScreen(),
          ContactUsScreen.routeName: (_) => ContactUsScreen(),
          AddIssueScreen.routeName: (_) => AddIssueScreen(),
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