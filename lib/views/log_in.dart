import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/views/add_person.dart';
// https://firebase.flutter.dev/docs/firestore/usage/

class LogIn extends StatelessWidget {

  static final id = "log_in";
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future logInToApp(context) async {
    print("login");
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: "ks@pl.pl", password: "123456");
      if (userCredential != null) {
        Navigator.pushNamed(context, AddPerson.id);
      }
       return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No user found for that email");
      } else if (e.code == "wrong-password") {
        print("Wrong password provided for the user");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Log In"),),
      body: Center(child: FlatButton(child: Text("Log Me!!"), onPressed: () => logInToApp(context),),),
    );
  }
}
