import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trash_map/models/issue.dart';
import 'package:trash_map/widgets/issue_item.dart';
import './add_issue.dart';
import './profile_screen.dart';
import './app_drawer.dart';

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

  List<Issue> issues=[
    Issue(id: '1', title: "Kachra saaf karo", desc: "BLABLA BLABLA BLABLA", importance: 3, imgURL: 'https://static.sciencelearn.org.nz/images/images/000/001/768/original/Recyclable-waste20160826-15827-ay9efw.jpg',location: "IIT BHU", coord: LatLng(23.6693, 86.1511), userID: "AnonySharma"),
    Issue(id: '2', title: "Road thik karo", importance: 4, imgURL: 'https://previews.123rf.com/images/radnatt/radnatt1705/radnatt170500071/79055020-old-broken-road-in-the-village-on-sunny-summer-day.jpg', location: "IIT BHU", coord: LatLng(25.6693, 84.1511), userID: "AnonySharma"),
    Issue(id: '1', title: "Kachra saaf karo", importance: 3, imgURL: 'https://static.sciencelearn.org.nz/images/images/000/001/768/original/Recyclable-waste20160826-15827-ay9efw.jpg',location: "IIT BHU", coord: LatLng(23.6693, 86.1511), userID: "AnonySharma"),
  ];
  
  addNewIssue(Issue issue) {
    issues.add(issue);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String,Object>> _pages = [
      {
        'title': "Issues nearby",
        'page': ListView.builder(
          itemCount: issues.length,
          itemBuilder: (ctx, index) {
            return IssueItem(issues[index]);
          }
        ),
      },
      {
        'title': "Map",
        'page': MapsScreen(),
      },
      {
        'title': "Notifications",
        'page': NotificationScreen(),
      },
    ];

    void _selectPage (int index) {
      setState(() {
        showFAB=(index==0);
        _selectedPageIndex = index;
      });
    }
    
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
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifications",
          ),
        ],
      ),
      floatingActionButton: !showFAB
      ? null
      : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            AddIssueScreen.routeName
          ).then((value) {
            setState(() {
              addNewIssue(value);
            });
          });
        },
      ),
    );
  }
}