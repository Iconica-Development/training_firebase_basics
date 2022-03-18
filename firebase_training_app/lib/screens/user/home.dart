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
  final TextEditingController _postController = TextEditingController();
  List<String> posts = [];
  @override
  void initState() {
    super.initState();
    () async {
      // Using onValue
      FirebaseDatabase.instance
          .ref()
          .child('posts')
          .onChildAdded
          .listen((event) {
        setState(() {
          posts.add(event.snapshot.value as String);
        });
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Hi, ${FirebaseAuth.instance.currentUser!.email!.split('@').first}',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (String post in posts) ...[
                      Text(post),
                      const Divider(),
                    ],
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showAddPostDialog();
              },
              child: const Text('Add post'),
            )
          ],
        ),
      ),
    );
  }

  showAddPostDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.black54,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextField(
                    controller: _postController,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseDatabase.instance.ref().child('posts').push().set(
                            _postController.text,
                          );
                      _postController.clear();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Post'),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
