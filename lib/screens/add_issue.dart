import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddIssueScreen extends StatefulWidget {
  static const routeName = '/add-issue-screen';

  @override
  AddIssueScreenState createState() => AddIssueScreenState();
}

class AddIssueScreenState extends State<AddIssueScreen> {
  File _image;
  var _picker = ImagePicker();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Issue"),),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300.0,
                color: Colors.cyanAccent,
                child: _image!=null
                ? Image.file(
                    _image,
                    fit: BoxFit.cover,
                  )
                : GestureDetector(
                    child: Icon(
                      Icons.add_a_photo,
                      size: 50,
                    ),
                    onTap: () {
                      _showPicker(context);
                    },
                  )
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Issue Title",
                  hintText: "Add a small title for the issue"
                ),
              )
            ]
          )
        ),
      ),
    );
  }
}