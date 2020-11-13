import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  signOut() async {
    await _firebaseAuth.signOut();
  }

  resetPassword({@required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
  
  signIn({@required String email, @required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return "Error";
    }
  }

  signUp({@required String email, @required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return "Error";
    }
  }
}