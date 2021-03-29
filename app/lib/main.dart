import 'package:flutter/material.dart';
import 'package:pay4/screens/home/home.dart';
import 'package:pay4/screens/error/error.dart';
import 'package:pay4/screens/wrapper.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:pay4/services/auth.dart';
import 'package:provider/provider.dart';

import 'models/pay4user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Error();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<Pay4User>.value(
              value: AuthService().user,
              initialData: null,
              child: MaterialApp(
                title: 'Pay4',
                theme: ThemeData(
                  // This is the theme of your application.
                  //
                  // Try running your application with "flutter run". You'll see the
                  // application has a blue toolbar. Then, without quitting the app, try
                  // changing the primarySwatch below to Colors.green and then invoke
                  // "hot reload" (press "r" in the console where you ran "flutter run",
                  // or simply save your changes to "hot reload" in a Flutter IDE).
                  // Notice that the counter didn't reset back to zero; the application
                  // is not restarted.
                  primarySwatch: Colors.blue,
                ),
                home: Wrapper(),
              ));
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Home();
      },
    );
  }
}
