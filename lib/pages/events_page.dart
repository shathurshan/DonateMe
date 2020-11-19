import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


import 'adding_event_page.dart';

class EventsPage extends StatefulWidget {
  static const routeName = '/events';

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override

  void initState() {
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(
      onMessage: (msg) {
        print(msg);
        print("aswi");
        return;
      },
      onLaunch: (msg) {
        print(msg);
        print("shathurshan");
        return;
      },
      onResume: (msg) {
        print(msg);
        print("vagi");

        return;
      },
    );
    fbm.getToken();
    fbm.subscribeToTopic('events');
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Events'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('events').snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final doc = streamSnapshot.data.documents;
          return ListView.builder(
            itemCount: doc.length,
            itemBuilder: (context, i) => Container(
              margin: EdgeInsets.all(10),
              child: Card(
                elevation: 4,
                child: Column(
                  children: <Widget>[
                    Text(doc[i]['name']),
                    Text(doc[i]['dis']),
                    Text(doc[i]['date']),
                    Text(doc[i]['text']),
                    Image.file(File(doc[i]['image'],),),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
//          Scaffold.of(context).showSnackBar(SnackBar(
//            content: Text('The post is added'),
//          ));
          Navigator.of(context).pushNamed(AddingEvent.routeName);
        },
        backgroundColor: Colors.pink,
      ),
    );
  }
}
