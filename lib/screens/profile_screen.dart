import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:trash_map/authentication_service.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';

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
  String userID;
  String imageURL="https://via.placeholder.com/512x512?text=User";

  File _image;
  var _picker=ImagePicker();
  Map<String,dynamic> userData;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final FocusNode _nameFoc = FocusNode();
  final FocusNode _phoneFoc = FocusNode();
  final FocusNode _addressFoc = FocusNode();

  @override
  void initState() {
    print(FirebaseAuth.instance.currentUser.uid);
    FirebaseFirestore.instance
      .collection('profile')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .get()
      .then((val){
        userData=val.data();
        // print(val.exists);
        // print(userData["name"]);
        userID=userData['uid'].toString();
        name=nameController.text=userData['name'].toString();
        email=emailController.text=userData['email'].toString();
        address=addressController.text=userData['address'].toString();
        phone=phoneController.text=userData['mobile'].toString();
      });

    setState(() {
      getImage();
    });
    super.initState();
  }
  
  Future uploadFile(image) async {    
    await FirebaseStorage.instance    
      .ref()    
      .child('users/$userID.jpeg')
      .putFile(image).then((task) {
        print(task.metadata.fullPath);
    });
    
    print('File Uploaded');
  }

  Future getImage() async {
    String url = await FirebaseStorage.instance.ref().child('users/$userID.jpeg').getDownloadURL();
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
                                child: CircleAvatar(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: "lib/assets/load.gif",
                                      image: imageURL,
                                      fit: BoxFit.fitWidth
                                    )
                                  )
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
                                  keyboardType: TextInputType.emailAddress,
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
                                  keyboardType: TextInputType.phone,
                                  maxLength: 10,
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
                    FirebaseFirestore.instance
                      .collection('profile')
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .update({
                        'name': nameController.text.trim(),
                        'email': emailController.text.trim(),
                        'address': addressController.text.trim(),
                        'mobile': phoneController.text.trim(),
                      })
                      .then((val){
                        print("Updated Profile");
                      });

                      uploadFile(_image);
                      getImage();
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
