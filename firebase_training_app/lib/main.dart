import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_training/screens/app.dart';
import 'package:firebase_training/screens/utils/error.dart';
import 'package:firebase_training/screens/utils/loading.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const Init());
}

class Init extends StatelessWidget {
  const Init({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const ErrorPage();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return const App();
          }

          return const Loading();
        },
      ),
    );
  }
}
