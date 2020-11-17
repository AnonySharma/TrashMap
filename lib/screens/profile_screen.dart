import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:trash_map/authentication_service.dart';
import 'package:trash_map/models/users.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';
  final User _user=new User(
    name: "Ankit",
    emailID: "abc@d.com",
    phoneNum: "1234567890",
    address: "IIT (BHU), Varanasi",
    profilePic: "",
    id: "2",
  );

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  String name;
  String email;
  String phone;
  String address;

  File _image;
  var _picker=ImagePicker();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final FocusNode _nameFoc = FocusNode();
  final FocusNode _phoneFoc = FocusNode();
  final FocusNode _addressFoc = FocusNode();

  @override
  void initState() {
    name=widget._user.name;
    email=widget._user.emailID;
    phone=widget._user.phoneNum;
    address=widget._user.address;
    nameController.text=name;
    emailController.text=email;
    phoneController.text=phone;
    addressController.text=address;
    super.initState();
  }
  
  final dbRef = FirebaseDatabase.instance.reference();

  _cropImage(filePath) async {
    await ImageCropper.cropImage(
        sourcePath: filePath.path,
        maxWidth: 1024,
        maxHeight: 1024,
        cropStyle: CropStyle.circle,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0)
    ).then((croppedImage){
      if (croppedImage  != null) {
        setState(() {
          _image = croppedImage ;
        });
      }
    });
  }

  _imgFromCamera() async {
    await _picker.getImage(
      source: ImageSource.camera, imageQuality: 50
    ).then((pickedfile){
      setState(() {
        if(pickedfile!=null)
          _image = File(pickedfile.path);
          _cropImage(_image);
      });
    });
  }

  _imgFromGallery() async {
    await _picker.getImage(
        source: ImageSource.gallery, imageQuality: 50
      ).then((pickedfile){
        setState(() {
          if(pickedfile!=null)
            _image = File(pickedfile.path);
            _cropImage(_image);
        });
      });
    }

  void _showPicker(ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Gallery'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(ctx).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
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
      appBar: AppBar(title: Text("Profile"),),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  // color: Colors.red,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Stack(fit: StackFit.loose, children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 140.0,
                                height: 140.0,
                                child: _image!=null
                                ? CircleAvatar(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.file(
                                      _image,
                                      fit: BoxFit.fitWidth
                                    )
                                  )
                                )
                                : CircleAvatar(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Icon(Icons.ac_unit),
                                  ),
                                )
                              ),
                            ],
                          ),
                          !_status
                          ? Padding(
                              padding: const EdgeInsets.only(top: 90.0, right: 100.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        _showPicker(context);
                                        // print(_image);
                                      });
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 25.0,
                                      child: Icon(
                                        Icons.camera_alt, 
                                        color: Colors.white, 
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            )
                          : Padding(
                            padding: const EdgeInsets.only(top: 0)
                          ),
                        ]),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Color(0xffFFFFFF),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25.0, top: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Personal Information',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                _status ? _getEditIcon() : Container(),
                              ],
                            )
                          ],
                        )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Name',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  controller: nameController,
                                  focusNode: _nameFoc,
                                  decoration: const InputDecoration(
                                    hintText: "Enter Your Name",
                                  ),
                                  enabled: !_status,
                                  autofocus: !_status,
                                  onEditingComplete: () {
                                    _fieldFocusChange(context, _nameFoc, _phoneFoc);
                                  },
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                            ],
                          )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Email ID',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Email ID"),
                                  enabled: false,
                                ),
                              ),
                            ],
                          )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Mobile',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  controller: phoneController,
                                  focusNode: _phoneFoc,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Mobile Number"),
                                  enabled: !_status,
                                  onEditingComplete: () {
                                    _fieldFocusChange(context, _phoneFoc, _addressFoc);
                                  },
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                            ],
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Address',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  controller: addressController,
                                  maxLines: null,
                                  focusNode: _addressFoc,
                                  decoration: const InputDecoration(
                                      hintText: "Enter your Address"),
                                  enabled: !_status,
                                  onEditingComplete: () {
                                    _addressFoc.unfocus();
                                  },
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                            ],
                          )
                        ),
                        !_status ? _getActionButtons() : Container(),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  child: Text("Sign Out"),
                  onPressed: () {
                    context.read<AuthenticationService>().signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      'login', (Route<dynamic> route) => false
                    );
                  },
                ),
              ],
            )
          ],
        ),
      )
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                  child: RaisedButton(
                child: Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    // _user.profilePic="12";
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                  child: RaisedButton(
                child: Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
