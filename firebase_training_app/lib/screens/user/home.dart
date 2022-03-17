import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> posts = [];
  @override
  void initState() {
    super.initState();
    () async {
      // Using get()
      // var res = await FirebaseDatabase.instance.ref().child('posts').get();
      // Map data = res.value as Map;
      // for (String post in data.values) {
      //   setState(() {
      //     posts.add(post);
      //   });
      // }

      // Using once()
      // var res = await FirebaseDatabase.instance.ref().child('posts').once();
      // Map data = res.snapshot.value as Map;
      // for (String post in data.values) {
      //   setState(() {
      //     posts.add(post);
      //   });
      // }

      // Using onValue
      // FirebaseDatabase.instance.ref().child('posts').onValue.listen((event) {
      //   Map data = event.snapshot.value as Map;
      //   setState(() {
      //     posts.add(data.values.first);
      //   });
      // });

      // Removing a value
      // FirebaseDatabase.instance
      // .ref()
      // .child('posts')
      // .child('-Mrehrejhrjh')
      // .remove();

      // Running a transaction
      FirebaseDatabase.instance
          .ref()
          .child('posts/-Mrehrejhrjh')
          .runTransaction((Object? post) {
        if (post == null) {
          return Transaction.abort();
        }

        Map<String, dynamic> newPost = {};

        try {
          newPost = Map<String, dynamic>.from(post as Map);
        } catch (e) {
          String _post = post as String;

          newPost['value'] = _post;
          newPost['likes'] = 0;
        }

        return Transaction.success(newPost);
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hi, ${FirebaseAuth.instance.currentUser!.email!.split('@').first}',
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (String post in posts) ...[
                Text(post),
                const Divider(),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
