import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:trash_map/screens/add_issue.dart';
import './profile_screen.dart';
import './app_drawer.dart';

import './issues_screen.dart';
import './notification_screen.dart';
import './maps_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex=0;
  bool showFAB=true;
  final List<Map<String,Object>> _pages = [
    {
      'title': "Issues nearby",
      'page': IssuesScreen(),
    },
    {
      'title': "Map",
      'page': MapsScreen(),
    },
    {
      'title': "Notifications",
      'page': NotificationScreen(),
    },
    // {
    //   'title': "Profile",
    //   'page': ProfileScreen(),
    // },
  ];

  void _selectPage (int index) {
    setState(() {
      showFAB=(index==0);
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: AppDrawer(),
      ),
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        actions: [
          IconButton(
            icon: Icon(Icons.face),
            onPressed: (){
              Navigator.of(context).pushNamed(
                ProfileScreen.routeName
              );
            }
          )
        ],
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.purple,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases),
            label: "Nearby",
            // title: Text("Nearby")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Map",
            // title: Text("Map")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifications",
            // title: Text("Notifications"),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.tag_faces),
          //   label: "Profile",
          //   // title: Text("Profile"),
          // )
        ],
      ),
      floatingActionButton: !showFAB
      ? null
      : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            AddIssueScreen.routeName
          );
          Flushbar(
            backgroundColor: Colors.green[600],
            icon: Icon(
              Icons.done,
              size: 28.0,
              color: Colors.black,
            ),
            leftBarIndicatorColor: Colors.black54,
            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
            messageText: Text(
              "Issue added",
              style: TextStyle(
                color: Colors.black54, 
                // fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            duration: Duration(seconds: 2),
            isDismissible: true,
          )..show(context);
        },
      ),
    );
  }
}