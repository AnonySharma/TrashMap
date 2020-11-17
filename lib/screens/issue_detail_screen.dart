import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../models/issue.dart';

class IssueDetailScreen extends StatefulWidget {
  static const routeName = '/issue-detail-screen';

  @override
  _IssueDetailScreenState createState() => _IssueDetailScreenState();
}

class _IssueDetailScreenState extends State<IssueDetailScreen> {
  GoogleMapController mapController;
  
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final issue = (ModalRoute.of(context).settings.arguments as Map<String,Object>)['issue'] as Issue;
    // print(issue);

    return Scaffold(
      appBar: AppBar(
        title: Text(issue.title),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.delete), 
          //   onPressed: () {}
          // )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: FadeInImage.assetNetwork(
                placeholder: 'lib/assets/load.gif', 
                image: issue.imgURL,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location: ", 
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width-140),
                        child: Text(
                          issue.location,
                          // "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GoogleMap(
                      liteModeEnabled: true,
                      mapToolbarEnabled: false,
                      onTap: (loc){
                        print(loc);
                      },
                      onMapCreated: _onMapCreated,
                      // myLocationEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: issue.coord,
                        zoom: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description: ", 
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(
                        // constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width-140),
                        child: Text(
                          issue.desc,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        tooltip: "Options",
        elevation: 7,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.edit),
            backgroundColor: Colors.yellow[800],
            label: "Edit",
            onTap: () {}
          ),
            SpeedDialChild(
            child: Icon(Icons.delete),
            backgroundColor: Colors.red,
            label: "Delete",
            onTap: () {}
          )
        ],
      )
    );
  }
}