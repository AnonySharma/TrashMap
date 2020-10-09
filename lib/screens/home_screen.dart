import 'package:flutter/material.dart';

import 'issues_screen.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';
import 'maps_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex=0;
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
      'title': "Add Issue",
      'page': IssuesScreen(),
    },
    {
      'title': "Notifications",
      'page': NotificationScreen(),
    },
    {
      'title': "Profile",
      'page': ProfileScreen(),
    },
  ];

  void _selectPage (int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pages[_selectedPageIndex]['title']),),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.purple,
        // type: BottomNavigationBarType.shifting,
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases),
            title: Text("Nearby"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text("Map")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text("Add"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text("Notifications"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tag_faces),
            title: Text("Profile"),
          )
        ],
      ),
    );
  }
}