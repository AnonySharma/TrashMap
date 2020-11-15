import 'package:flushbar/flushbar.dart';
// import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trash_map/authentication_service.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup-screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final usernameController = TextEditingController();
  final nameController = TextEditingController();

  final FocusNode _emFoc = FocusNode();
  final FocusNode _unFoc = FocusNode();
  final FocusNode _nmFoc = FocusNode();
  final FocusNode _psFoc = FocusNode();

  int errEmail = 0; //1-empty, 2-invalid, 3-registered
  int errPass = 0; //1-empty
  int errUserName = 0; //1-empty, 2-invalid ,3-registered
  int errName = 0; //1-empty

  void signUp() {
    int err=0;
    if(emailController.text.isEmpty) 
      setState(() {
        err=1;
        errEmail=1;
      });
    else {
      if(!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(emailController.text))
        setState(() {
          err=1;
          errEmail=2;
        });
    }

    if(passController.text.length<6)
      setState(() {
        err=1;
        errPass=1;
      });

    if(usernameController.text.isEmpty)
      setState(() {
        err=1;
        errUserName=1;
      });
    else {
      if(!RegExp(r"^(?=[a-zA-Z0-9._]{5,20}$)(?!.*[_.]{2})[^_.].*[^_.]$").hasMatch(usernameController.text))
      {
        setState(() {
          err=1;
          errUserName=2;
        });
        Flushbar(
          backgroundColor: Colors.yellow[600],
          icon: Icon(
            Icons.error_outline,
            size: 28.0,
            color: Colors.black,
          ),
          leftBarIndicatorColor: Colors.black,
          messageText: Text(
            "Username must be of this form:\n\n* Contains only alphanumeric characters, underscores and dots\n\n* Doesn't starts or ends with _ or .\n\n* Length is in between 5-20\n\n* No two symbols can be together",
            style: TextStyle(
              color: Colors.black87, 
              // fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          duration: Duration(seconds: 5),
          isDismissible: true,
        )..show(context);
      }
    }

    if(nameController.text.isEmpty)
      setState(() {
        err=1;
        errName=1;
      });

    if(err==1)
      return;
    //-----------------------------------------
    // context.read<AuthenticationService>().userReset();
    context.read<AuthenticationService>().signUp(
      email: emailController.text.trim(),
      password: passController.text.trim(),
    );

    if(context.read<AuthenticationService>().userExists())
    {
      setState(() {
        err=1;
        errEmail=3;
      });
      context.read<AuthenticationService>().userReset();
    }

    if(err==1)
      return;

    Navigator.of(context).pushNamedAndRemoveUntil(
      'login', (Route<dynamic> route) => false
    );
    
    Flushbar(
      backgroundColor: Colors.lightGreenAccent[700],
      icon: Icon(
        Icons.check_circle_outline,
        size: 28.0,
        color: Colors.black,
      ),
      leftBarIndicatorColor: Colors.black,
      messageText: Text(
        "Signed Up successfully",
        style: TextStyle(
          color: Colors.white, 
          // fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      duration: Duration(seconds: 5),
      isDismissible: true,
    )..show(context);
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("TrashMap"),),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text("Welcome to TrashMap", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(height: 50,),
              TextField(
                // autocorrect: false,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  errorText: (errEmail==1) ? "The email address can not be empty" : (errEmail==2) ? "The email address is badly formatted" : (errEmail==3) ? "The email address is already in use by another account" : null,
                ),
                focusNode: _emFoc,
                onChanged: (_){
                  setState(() {
                    errEmail=0;
                  });
                },
                onEditingComplete: () {
                  _fieldFocusChange(context, _emFoc, _unFoc);
                },
                textInputAction: TextInputAction.next,
              ),
              TextField(
                // autocorrect: false,
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  errorText: errUserName==1 ? "Username can't be empty" : errUserName==2 ? "The username is badly formatted" : null,
                ),
                focusNode: _unFoc,
                onChanged: (_){
                  setState(() {
                    errUserName=0;
                  });
                },
                onEditingComplete: (){
                  _fieldFocusChange(context, _unFoc, _nmFoc);
                },
                textInputAction: TextInputAction.next,
              ),
              TextField(
                // autocorrect: false,
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  errorText: errName==1 ? "Name must be 2 character long" : null,
                  // errorText: errName
                ),
                focusNode: _nmFoc,
                onChanged: (_){
                  setState(() {
                    errName=0;
                  });
                },
                onEditingComplete: (){
                  _fieldFocusChange(context, _unFoc, _psFoc);
                },
                textInputAction: TextInputAction.next,
              ),
              TextField(
                autocorrect: false,
                obscureText: true,
                controller: passController,
                decoration: InputDecoration(
                  labelText: "Password",
                  errorText: errPass==1 ? "Password must be 6 characters long" : null,
                ),
                focusNode: _psFoc,
                onChanged: (_){
                  setState(() {
                    errPass=0;
                  });
                },
                onEditingComplete: () {
                  _psFoc.unfocus();
                },
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 10,),
              RaisedButton(
                child: Text("Signup"),
                onPressed: () {

                  signUp();
                },
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Regsitered?", style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(width: 10,),
                  GestureDetector(
                    child: Text("Login", style: TextStyle(color: Colors.blueAccent),),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}