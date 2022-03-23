import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_training/screens/user/add_post.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map> posts = [];
  Map users = {};
  @override
  void initState() {
    super.initState();
    () async {
      var res = await FirebaseDatabase.instance.ref().child('users').get();
      users = res.value as Map<dynamic, dynamic>;
      // Using onValue
      FirebaseDatabase.instance
          .ref()
          .child('posts')
          .onChildAdded
          .listen((event) {
        setState(() {
          posts.add(
            (event.snapshot.value as Map<dynamic, dynamic>),
          );
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
              height: MediaQuery.of(context).size.height - 150,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (Map post in posts) ...[
                      if (post['text'] != null)
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(
                            bottom: 20,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  const Spacer(),
                                  Text(
                                    '${users[post['by']]['name']}',
                                  ),
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${users[post['by']]['name'][0]}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 35,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  const Spacer(),
                                  Text(
                                    post['text'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (post.containsKey('image'))
                                    SizedBox(
                                      height: 100,
                                      child: Image.network(
                                        post['image'],
                                      ),
                                    ),
                                  if (post.containsKey('image')) const Spacer(),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                    ],
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const AddPost();
                      },
                    ),
                  );
                },
                child: const Text('Add post'),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
