import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//https://medium.com/firebase-tips-tricks/how-to-use-firebase-authentication-in-flutter-50e8b81cb29f

class AddPerson extends StatefulWidget {

  static final id = "add_person";

  @override
  _AddPersonState createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {

  final fb = FirebaseFirestore.instance;
  String name;
  int age;

  void _addMeLogged(name, age) {
    var fbUser =  FirebaseAuth.instance.currentUser;
      if(name != null && age != null) {
        print("adding...");
        fb.collection("users").doc("$name-$age").set({
          "name": name,
          "age": age,
          "address": {
            "street": "Wall Street",
            "city": "London"
          }
        }).then((_) =>
        {
          print("Success!"),
        });
      }
  }

  void _updateMeLoggedUser(name, age) async {

    var fbUser =  FirebaseAuth.instance.currentUser;
    if (name != null && age != null) {
      fb.collection("users").doc("jack-38")
          .update({"name": name, "age": age})
          .then((_) {
        print("Updated!");
      });
    }
  }

  void _deleteData() async {
    var fbUser =  FirebaseAuth.instance.currentUser;
    fb.collection("users").doc(fbUser.uid).delete().then((_) {
      print("Deleted!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Person"),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(decoration: InputDecoration(hintText: "name"), onSubmitted: (value) {
                name = value;
              },),
              TextField(decoration: InputDecoration(hintText: "age"), onSubmitted: (value) {
                age =  int.parse(value);
              },),
              FlatButton(child: Text("Add person"), onPressed: () {
               _addMeLogged(name, age);
              },),
              FlatButton(child: Text("Update person"), onPressed: () {
                _updateMeLoggedUser(name, age);
              },),
              FlatButton(child: Text("Delete person"), onPressed: () {
                _deleteData();
              },),
            ],
          ),
        ),
      ),
    );
  }
}
