import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternew/profile/edit_profile.dart';
import 'package:flutternew/profile/organList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'profile_form.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProfile.routeName);
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
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
                        String userId = futureSnapshot.data.uid;
                        return OrganList(
                          document[index]['text'],
                          document[index]['userID'] == userId,
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
    );
  }
}
