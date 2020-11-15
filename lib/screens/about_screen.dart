import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  static const routeName = '/about-screen';

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  AppBar ourAppBar = AppBar(title: Text('App Info'),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ourAppBar,
      body: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Container(
                width: double.infinity,
                // height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - ourAppBar.preferredSize.height)*0.32,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text('TrashMap', style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.w700),),
                    Divider(),
                    SizedBox(height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - ourAppBar.preferredSize.height)*0.01,),
                    Text("This app aims to engage people in the process of building a cleaner India. The thought is to give a platform to all residents to report the trash close to their locality, and that will be updated to a heat-map, which will assist the municipal corporation with cleaning the spots as per the number of requests per zone."),
                  ],
                ),
              )
            ),
            Card(
              elevation: 5,
              child: Container(
                width: double.infinity,
                // height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - ourAppBar.preferredSize.height)*0.22,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text('About the Developers', style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.w700),),
                    Divider(),
                    SizedBox(height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - ourAppBar.preferredSize.height)*0.01,),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.devices),
                              SizedBox(width: 10,),
                              Text('Ankit Kumar Sharma', style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.devices),
                              SizedBox(width: 10,),
                              Text('Khushi Jamod', style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.devices),
                              SizedBox(width: 10,),
                              Text('Raghav Garg', style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.devices),
                              SizedBox(width: 10,),
                              Text('Sakshi Maheshwari', style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      )
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        children: [
                          Icon(Icons.code),
                          SizedBox(width: 10,),
                          Linkify(
                            text: "https://www.github.com/AnonySharma/TrashMap",
                            linkStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.normal),
                            onOpen: (link) async {
                              if(await canLaunch(link.url))
                                await launch(link.url);
                              else
                                throw 'Could not launch $link';
                            },
                          )
                        ],
                      )
                    )
                  ],
                ),
              )
            )
          ]
        ),
      ),
    );
  }
}