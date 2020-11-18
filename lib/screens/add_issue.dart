import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../models/issue.dart';

class AddIssueScreen extends StatefulWidget {
  static const routeName = '/add-issue-screen';

  @override
  AddIssueScreenState createState() => AddIssueScreenState();
}

class AddIssueScreenState extends State<AddIssueScreen> {
  FocusNode _tF = FocusNode();
  FocusNode _dF = FocusNode();

  File _image;
  var _picker = ImagePicker();
  double _importance=1;
  final titleController = TextEditingController();
  final descController = TextEditingController();
  String _location="Bokaro Steel City";
  LatLng _coord;
  String imageURL;
  String id;
  String userID = FirebaseAuth.instance.currentUser.uid;

  initState() {
    id=UniqueKey().toString();
    super.initState();
  }

  Future uploadFile(image) async {
    await FirebaseStorage.instance    
      .ref()    
      .child('issues/$id.jpeg')
      .putFile(image).then((task) {
        print(task.metadata.fullPath);
    });
    
    print('File Uploaded');
  }
  
  Future getImage() async {
    String url = await FirebaseStorage.instance.ref().child('issues/$id.jpeg').getDownloadURL();
    print("------------------------------------------------\nURL: $url");

    setState(() {
      imageURL=url;
    });
    print(imageURL);
  }

  _cropImage(filePath) async {
    await ImageCropper.cropImage(
      sourcePath: filePath.path,
      maxWidth: 1024,
      maxHeight: 1024,
      // aspectRatioPresets: []
      cropStyle: CropStyle.rectangle,
      // aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0)
      )
      .then((croppedImage) {
      if (croppedImage != null) {
        setState(() {
          _image = croppedImage;
        });
      }
    });
  }

  _imgFromCamera() async {
    await _picker
        .getImage(source: ImageSource.camera, imageQuality: 50)
        .then((pickedfile) {
      setState(() {
        if (pickedfile != null) _image = File(pickedfile.path);
        _cropImage(_image);
      });
    });

    print(_image);
  }

  _imgFromGallery() async {
    await _picker
        .getImage(source: ImageSource.gallery, imageQuality: 50)
        .then((pickedfile) {
      setState(() {
        if (pickedfile != null) _image = File(pickedfile.path);
        _cropImage(_image);
      });
    });

    print(_image);
  }

  void _showPicker(ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(ctx).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(ctx).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
      );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Issue"),),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300.0,
                color: Colors.grey[400],
                child: _image!=null
                ? Image.file(
                    _image,
                    fit: BoxFit.cover,
                  )
                : GestureDetector(
                    child: Icon(
                      Icons.add_a_photo,
                      size: 80,
                    ),
                    onTap: () {
                      _showPicker(context);
                    },
                  )
              ),
              TextField(
                controller: titleController,
                focusNode: _tF,
                decoration: InputDecoration(
                  labelText: "Title",
                  hintText: "Add a title for the issue"
                ),
                onEditingComplete: () {
                  _fieldFocusChange(context, _tF, _dF);
                },
                textInputAction: TextInputAction.next,
              ),
              TextField(
                maxLines: null,
                controller: descController,
                focusNode: _dF,
                decoration: InputDecoration(
                  labelText: "Desciption",
                  hintText: "Describe the issue briefly"
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Importance",
                  ),
                  Slider(
                    min: 1, 
                    max: 5,
                    value: _importance,
                    divisions: 4,
                    label: _importance.toInt().toString(),        
                    onChanged: (val) {
                      setState(() {
                        _importance=val;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Location ${_location!=null?": $_location":""}"),
                  IconButton(
                    icon: Icon(Icons.add_location_alt), 
                    onPressed: () {
                    
                    }
                  )
                ],
              )
            ]
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {
          print(_image);
          if(_image!=null)
          {
            uploadFile(_image);
            getImage();
          }

          print(imageURL);
          print(_image);

          Issue issue = new Issue(
            title: titleController.text,
            desc: descController.text,
            imgURL: imageURL??"https://via.placeholder.com/468x60?text=New+Issue",
            location: _location,
            coord: _coord,
            id: id,
            userID: userID,
            importance: _importance.toInt(),
          );
          // print(titleController.text);
          // print(descController.text);
          // print(_image.toString());
          // print(_location);
          // print(_importance);
          // setState(() {
          //   addNewIssue(issue);
          // });

          // print(issues.length);
          Navigator.of(context).pop(issue);
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