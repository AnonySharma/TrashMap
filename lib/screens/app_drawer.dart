import 'package:flutter/material.dart';
import './about_screen.dart';
import './contact_screen.dart';

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
        if(text=='Guide') {
          // Navigator.of(context).pushNamed(
          //   GuideScreen.routeName
          // );
        } else if(text=='Contact Us') {
          Navigator.of(context).popAndPushNamed(
            ContactUsScreen.routeName
          );
        } else if(text=='App Info') {
          Navigator.of(context).pushNamed(
            AboutScreen.routeName
         );
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
            color: Theme.of(context).primaryColor,
            child: Text(
              'TrashMap', 
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Colors.white,
              )
            ),
          ),
          SizedBox(height: 20,),
          // drawerTile(context, Icons.batch_prediction, 'Guide'),
          drawerTile(context, Icons.people, 'Contact Us'),
          drawerTile(context, Icons.info, 'App Info'),
      ],
    );
  }
}