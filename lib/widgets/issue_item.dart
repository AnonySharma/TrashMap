import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trash_map/assets/up_down_icons.dart';
import 'package:trash_map/models/issue.dart';
import 'package:trash_map/screens/issue_detail_screen.dart';

class IssueItem extends StatefulWidget {
  final Issue issue;
  IssueItem(this.issue);

  @override
  _IssueItemState createState() => _IssueItemState();
}

class _IssueItemState extends State<IssueItem> {
  bool _isUpvoted=false, _isDownvoted=false;
  String imageURL;

  Future getImage(id) async {
    String url = await FirebaseStorage.instance.ref().child('issues/$id.jpeg').getDownloadURL();
    print("------------------------------------------------\nURL: $url");

    setState(() {
      imageURL=url;
    });
    print(imageURL);
  }

  @override
  void initState() {
    getImage(widget.issue.id);
    super.initState();
  }
  void selectIssue(ctx) {
    print('Selected Issue');
    Navigator.of(ctx).pushNamed(
      IssueDetailScreen.routeName,
      arguments: {
        'issue': widget.issue,
        'image': imageURL,
      }
    );
  }

  String calcDist(LatLng loc) {
    return '10 m';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectIssue(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        elevation: 5,
        margin: const EdgeInsets.symmetric(
          horizontal: 7, 
          vertical: 5,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7),
                    topRight: Radius.circular(7),
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'lib/assets/load.gif', 
                    image: imageURL??"https://via.placeholder.com/468x60?text=New+Issue",
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 5,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      widget.issue.title,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    )
                  ),
                ),
              ]
            ),
            Padding(
              padding: const EdgeInsets.all(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(UpDown.up_fat, color: _isUpvoted?Colors.blue:Colors.grey,), 
                        onPressed: (){
                          setState(() {
                            _isUpvoted=!_isUpvoted;
                            _isDownvoted=false;
                          });
                        }, 
                        // splashColor: Colors.blueAccent[100], 
                        splashRadius: 1,
                      ),
                      // SizedBox(width: 7, child: FittedBox(fit: BoxFit.fitWidth, child: Text("2"),),),
                      IconButton(
                        icon: Icon(UpDown.down_fat, color: _isDownvoted?Colors.red:Colors.grey,), 
                        onPressed: (){
                          setState(() {
                            _isDownvoted=!_isDownvoted;
                            _isUpvoted=false;
                          });
                        }, 
                        // splashColor: Colors.redAccent[100], 
                        splashRadius: 1,
                      ),
                      // SizedBox(width: 7, child: FittedBox(fit: BoxFit.fitWidth, child: Text("2"),),),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(
                        width: 5,
                      ),
                      Text('${calcDist(widget.issue.coord)}'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.priority_high),
                      SizedBox(width: 5,),
                      Text(widget.issue.importance.toString()),
                      SizedBox(width: 15,),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}