import 'package:flushbar/flushbar.dart';
// import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trash_map/authentication_service.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text("TrashMap"),),
      body: Container(
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
                context.read<AuthenticationService>().resetPassword(
                  email: emailController.text.trim(),
                );
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
              },
            ),
            SizedBox(height: 10,),
            RaisedButton(
              child: Text("Login"),
              onPressed: () {
                context.read<AuthenticationService>().signIn(
                  email: emailController.text.trim(),
                  password: passController.text.trim(),
                );

                // emailController.text="";
                // passController.text="";
                Flushbar(
                  backgroundColor: Colors.green[700],
                  icon: Icon(
                    Icons.mail_rounded,
                    size: 28.0,
                    color: Colors.black,
                  ),
                  leftBarIndicatorColor: Colors.black,
                  // titleText: Text(
                  //   "Logged In successfully",
                  //   style: TextStyle(
                  //     color: Colors.black, 
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 16,
                  //   ),
                  // ),
                  messageText: Text(
                    "Logged In successfully",
                    style: TextStyle(
                      color: Colors.white, 
                      // fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  duration: Duration(seconds: 2),
                  isDismissible: true,
                )..show(context);
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
                    context.read<AuthenticationService>().signUp(
                      email: emailController.text.trim(),
                      password: passController.text.trim(),
                    );

                    // emailController.text="";
                    // passController.text="";
                    
                    // Flushbar(
                    //   backgroundColor: Colors.green[700],
                    //   icon: Icon(
                    //     Icons.mail_rounded,
                    //     size: 28.0,
                    //     color: Colors.black,
                    //   ),
                    //   leftBarIndicatorColor: Colors.black,
                    //   // titleText: Text(
                    //   //   "Logged In successfully",
                    //   //   style: TextStyle(
                    //   //     color: Colors.black, 
                    //   //     fontWeight: FontWeight.bold,
                    //   //     fontSize: 16,
                    //   //   ),
                    //   // ),
                    //   messageText: Text(
                    //     "Logged In successfully",
                    //     style: TextStyle(
                    //       color: Colors.white, 
                    //       // fontWeight: FontWeight.bold,
                    //       fontSize: 14,
                    //     ),
                    //   ),
                    //   duration: Duration(seconds: 2),
                    //   isDismissible: true,
                    // )..show(context);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}