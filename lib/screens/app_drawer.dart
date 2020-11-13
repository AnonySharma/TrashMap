import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  Widget drawerTile (BuildContext context, IconData icon, String text) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        text,
        style: TextStyle(
          //fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        if(text=='Filters') {
          // Navigator.of(context).pushNamed(
          //   FilterScreen.routeName
          // );
        } else if(text=='Categories') {
          // Navigator.of(context).popAndPushNamed(
          //   TabsScreen.routeName
          // );
          //Navigator.of(context).pop();
        } else if(text=='About') {
          // Navigator.of(context).pushNamed(
          //   AboutScreen.routeName
         // );
        }
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 220,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'TrashMap', 
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              )
            ),
          ),
          drawerTile(context, Icons.batch_prediction, 'Guide'),
          drawerTile(context, Icons.people, 'Contact Us'),
          drawerTile(context, Icons.info, 'App Info'),
      ],
    );
  }
}