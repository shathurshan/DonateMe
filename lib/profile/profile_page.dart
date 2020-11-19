import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternew/profile/organList.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'profile_form.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _pickedImageCam;
  File _pickedImagegal;
  final picker = ImagePicker();

  void _pickImage() async {
    final pickedImageFile = await picker.getImage(source: ImageSource.camera);
    setState(
      () {
        _pickedImageCam = File(pickedImageFile.path);
      },
    );
  }

  void _getImage() async {
    final _getImageFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _pickedImagegal = File(_getImageFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
//          Divider(height: 40,),
          Container(
            margin: EdgeInsets.all(20),
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                radius: 80,
                backgroundImage: _pickedImagegal != null
                    ? FileImage(_pickedImagegal)
                    : _pickedImageCam != null
                        ? FileImage(_pickedImageCam)
                        : null,
                child: IconButton(
                  onPressed: () {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.black54,
                        content: Row(
                          children: <Widget>[
                            FlatButton.icon(
                              onPressed: _pickImage,
                              icon: Icon(Icons.camera_alt),
                              label: Text(
                                'Camera',
                              ),
                            ),
                            FlatButton.icon(
                              onPressed: _getImage,
                              icon: Icon(Icons.image),
                              label: Text(
                                'Gallery',
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.add_a_photo,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 40,
            onPressed: () {
              Navigator.of(context).pushNamed(ProfileForm.routeName);
            },
          ),
          StreamBuilder(
            stream: Firestore.instance
                .collection('details')
                .orderBy('time', descending: true)
                .snapshots(),
            builder: (ctx, streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final document = streamSnapshot.data.documents;
              return Expanded(
                child: FutureBuilder(
                  future: FirebaseAuth.instance.currentUser(),
                  builder: (ctx, futureSnapshot) {
                    if (futureSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: Text('Add the organs'),
                      );
                    }
                    return ListView.builder(
                      reverse: true,
                      itemCount: document.length,
                      itemBuilder: (ctx, index) {
                        return OrganList(
                          document[index]['text'],
                          document[index]['userID'] == futureSnapshot.data.uid,
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
//      drawer: AppDrawerWid(),
    );
  }
}
