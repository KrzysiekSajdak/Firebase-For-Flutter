import 'package:flutter/material.dart';
import 'package:flutter_firebase/views/add_person.dart';
import 'package:flutter_firebase/views/log_in.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase App',
      initialRoute: LogIn.id,
      routes: {
        LogIn.id: (context) => LogIn(),
        AddPerson.id: (context) => AddPerson(),
      },
    );
  }
}

