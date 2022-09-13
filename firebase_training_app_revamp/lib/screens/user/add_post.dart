import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _postController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              height: MediaQuery.of(context).size.height -
                  150 -
                  MediaQuery.of(context).viewInsets.bottom,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: TextField(
                      controller: _postController,
                      maxLines: null,
                      maxLength: 500,
                    ),
                  ),
                  const Spacer(),
                  if (_image != null)
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Image.memory(_image!),
                    ),
                  const Spacer(),
                  _image == null
                      ? SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              _picker
                                  .pickImage(source: kIsWeb || Platform.isIOS ? ImageSource.gallery : ImageSource.camera)
                                  .then((image) async {
                                _image = await image?.readAsBytes();
                                setState(() {});
                              });
                            },
                            child: const Text('Add image'),
                          ),
                        )
                      : SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _image = null;
                              });
                            },
                            child: const Text('Remove image'),
                          ),
                        ),
                  const Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (_postController.text.isNotEmpty) {
                    var uuid = const Uuid().v4();
                    if (_image != null) {
                      await FirebaseStorage.instance
                          .ref()
                          .child('images')
                          .child(FirebaseAuth.instance.currentUser!.uid)
                          .child(uuid)
                          .putData(_image!);
                    }
                    FirebaseDatabase.instance
                        .ref()
                        .child('posts')
                        .child(uuid)
                        .update(
                      {
                        'text': _postController.text,
                        if (_image != null)
                          'image': await FirebaseStorage.instance
                              .ref()
                              .child('images')
                              .child(FirebaseAuth.instance.currentUser!.uid)
                              .child(uuid)
                              .getDownloadURL(),
                        'by': FirebaseAuth.instance.currentUser?.uid,
                      },
                    );
                    _postController.clear();
                    Navigator.of(context).pop();
                  } else {
                    const snackBar = SnackBar(
                      content: Text("Don't post empty posts please :("),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text('Post!'),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
