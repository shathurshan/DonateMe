import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutternew/widget/app_drawre_widget.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Future<void> getAuthenticateUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    setState(() {
      authUid = uid;
    });
  }

  String authUid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Notification'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('notification').snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final doc = streamSnapshot.data.documents;
          return ListView.builder(
            itemCount: doc.length,
            itemBuilder: (context, i) {
              return authUid == doc[i]['senderId']
                  ? Container(
                      margin: EdgeInsets.all(8),
                      child: Card(
                        elevation: 4,
                        child: Column(
                          children: <Widget>[
                            // Text(doc[i]['date']),
                            // Text(doc[i]['name']),
                            // Text(doc[i]['sender']),
                            // Text(doc[i]['senderId']),
                            // Text(doc[i]['time']),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Hi !!! " +
                                    doc[i]['sender'] +
                                    " Your Profile is viewd by " +
                                    doc[i]['name'] +
                                    " on " +
                                    doc[i]['date'] +
                                    " at " +
                                    doc[i]['time'],
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      // child: Center(
                      //   child: Text(
                      //     "No nortification you get",
                      //   ),
                      // ),
                    );
            },
          );
        },
      ),
      drawer: AppDrawerWid(),
    );
  }
}
