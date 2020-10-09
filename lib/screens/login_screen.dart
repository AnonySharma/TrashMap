import 'package:flutter/material.dart';
import 'package:trash_map/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text("Welcome to TrashMap", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          SizedBox(height: 50,),
          TextField(
            autocorrect: false,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
            )
          ),
          TextField(
            autocorrect: false,
            obscureText: true,
            controller: passController,
            decoration: InputDecoration(
              labelText: "Password",
            )
          ),
          SizedBox(height: 50,),
          GestureDetector(
            child: Text("Forgot password", style: TextStyle(color: Colors.blueAccent),),
            onTap: () {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text("Changing Password"),
                  action: SnackBarAction(
                    label: "OK", 
                    onPressed: () {}
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 10,),
          RaisedButton(
            child: Text("Login"),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                HomeScreen.routeName
              );
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
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text("No need to sign up, Login directly."),
                      backgroundColor: Colors.green,
                      action: SnackBarAction(
                        label: "OK", 
                        textColor: Colors.white,
                        onPressed: () {}
                      ),
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}