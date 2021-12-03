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
            itemBuilder: (context, i) {
              String url = doc[i]['image'];
              print(url);
              return Container(
                margin: EdgeInsets.all(10),
                child: Card(
                  elevation: 4,
                  child: Column(
                    children: <Widget>[
                      Text(doc[i]['name']),
                      Text(doc[i]['dis']),
                      Text(doc[i]['date']),
                      Text(doc[i]['text']),
                      Image.network(
                        url,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddingEvent.routeName);
        },
        backgroundColor: Colors.pink,
      ),
    );
  }
}
