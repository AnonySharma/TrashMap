import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  static const routeName = '/contact-screen';

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  AppBar ourAppBar = AppBar(title: Text('Contact Screen'),);

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
                    SizedBox(height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - ourAppBar.preferredSize.height)*0.01,),
                    Row(
                      children: [
                        Text("For further queries, contact us on:\n", textAlign: TextAlign.left,),
                      ],
                    ),
                    Row(
                        children: [
                          Icon(Icons.email),
                          SizedBox(width: 10,),
                          Linkify(
                            text: "mailto:ankit.kumar.cse19@itbhu.ac.in",
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
                  ],
                ),
              )
            ), 
          ]
        ),
      ),
    );   
  }
}