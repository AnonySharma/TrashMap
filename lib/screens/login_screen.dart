import 'package:flushbar/flushbar.dart';
// import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trash_map/authentication_service.dart';
import 'package:trash_map/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final FocusNode _emFoc = FocusNode();
  final FocusNode _psFoc = FocusNode();

  int errEmail=0; //1-empty, 2-invalid, 3-unregistered
  int errPass=0; //1-empty
  
  logIn () {
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

    if(err==1)
      return;

    // context.read<AuthenticationService>().unregisteredReset();
    context.read<AuthenticationService>().signIn(
      email: emailController.text.trim(),
      password: passController.text.trim(),
    );

    // print(context.read<AuthenticationService>().userUnregistered());
    if(context.read<AuthenticationService>().userUnregistered())
    {
      setState(() {
        err=1;
        errEmail=3;
      });
      context.read<AuthenticationService>().unregisteredReset();
    }

    if(err==1)
      return;
    print("$err,$errEmail\n-----------------------------------------------------------------------------");

    Flushbar(
      backgroundColor: Colors.lightGreenAccent[700],
      icon: Icon(
        Icons.check_circle_outline,
        size: 28.0,
        color: Colors.black,
      ),
      leftBarIndicatorColor: Colors.black,
      messageText: Text(
        "Logged In successfully",
        style: TextStyle(
          color: Colors.white, 
          // fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      duration: Duration(seconds: 4),
      isDismissible: true,
    )..show(context);
  }

  forgetPass() {
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

    if(err==1)
      return;

    context.read<AuthenticationService>().resetPassword(
      email: emailController.text.trim(),
    );

    if(context.read<AuthenticationService>().userUnregistered())
    {
      setState(() {
        err=1;
        errEmail=3;
      });
      context.read<AuthenticationService>().unregisteredReset();
    }

    if(err==1)
      return;
    
    Flushbar(
      backgroundColor: Colors.yellow[800],
      icon: Icon(
        Icons.mail_rounded,
        size: 28.0,
        color: Colors.black,
      ),
      leftBarIndicatorColor: Colors.black54,
      titleText: Text(
        "Check your email",
        style: TextStyle(
          color: Colors.black, 
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      messageText: Text(
        "Change your password by clicking on the link in the mail.",
        style: TextStyle(
          color: Colors.black54, 
          // fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      duration: Duration(seconds: 4),
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
                  errorText: (errEmail==1) ? "The email address can not be empty" : (errEmail==2) ? "The email address is badly formatted" : (errEmail==3) ? "The email address is either un-registered or deleted" : null,
                ),
                focusNode: _emFoc,
                onChanged: (_){
                  setState(() {
                    errEmail=0;
                  });
                },
                onEditingComplete: () {
                  _fieldFocusChange(context, _emFoc, _psFoc);
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
              SizedBox(height: 50,),
              GestureDetector(
                child: Text("Forgot password", style: TextStyle(color: Colors.blueAccent),),
                onTap: () {
                  forgetPass();
                },
              ),
              SizedBox(height: 10,),
              RaisedButton(
                child: Text("Login"),
                onPressed: () {
                  logIn();
                },
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New here?", style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(width: 10,),
                  GestureDetector(
                    child: Text("Signup", style: TextStyle(color: Colors.blueAccent),),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        SignUpScreen.routeName,
                      );

                      setState(() {
                        errEmail=0;
                        errPass=0;
                      });
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