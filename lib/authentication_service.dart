import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService {
  User user;
  final FirebaseAuth _firebaseAuth;
  bool exists=false;
  bool unregistered=false;
  
  AuthenticationService(this._firebaseAuth);
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  // getFirebaseAuth() {
  //   return _firebaseAuth;
  // }

  signOut() async {
    await _firebaseAuth.signOut();
  }

  resetPassword({@required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email).catchError((e){
      print("RESET ERROR: $e");
      if(e.code == "user-not-found" || e.code == "invalid-email") {
        unregistered=true;
        print("Unregistered");
      }
    });
  }
  
  signIn({@required String email, @required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password).catchError((_){
        print("AWAIT ERROR: $_, ${_.code}");
        if(_.code=="user-not-found")
        {
          unregistered=true;
          print("Unregistered");
        }
      });

      // return "Signed In";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      // return "Error";
    }

    user = _firebaseAuth.currentUser;
  }

  signUp({@required String email, @required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).catchError((_){
        // print("AWAIT ERROR: $_, ${_.code}");
        if(_.code=="email-already-in-use")
        {
          exists=true;
          print("Exists");
        }
      });
      // return "Signed Up";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      // if(e.code=="auth/email-already-in-use")
      //   return "exists";
      // return "Error";
    }

    user = _firebaseAuth.currentUser;
  }

  bool userExists() {
    return exists;
  }

  userReset() {
    exists=false;
  }

  bool userUnregistered() {
    return unregistered;
  }

  unregisteredReset() {
    unregistered=false;
  }
}