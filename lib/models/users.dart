import 'package:flutter/foundation.dart';

class MyUser {
  final String id;
  final String name;
  final String profilePic;
  final String phoneNum;
  final String emailID;
  final String address;
  bool isAdmin;

  MyUser({
    @required this.id, 
    @required this.name, 
    this.profilePic, 
    @required this.phoneNum, 
    @required this.emailID, 
    this.address, 
    this.isAdmin=false
  });
}