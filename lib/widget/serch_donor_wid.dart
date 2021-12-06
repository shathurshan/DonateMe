import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternew/profile/organList.dart';
import 'package:intl/intl.dart';

class DonorSerWid extends StatefulWidget {
  static const routeName = '/serdonowid';

  final Uid;
  final name;
  final number;
  final mail;
  final type;

  DonorSerWid(
    this.Uid,
    this.name,
    this.number,
    this.mail,
    this.type,
  );

  @override
  _DonorSerWidState createState() => _DonorSerWidState();
}

class _DonorSerWidState extends State<DonorSerWid> {
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future newTable() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    await Firestore.instance.collection('notification').add({
      'time': now.toIso8601String(),
      'date': formatted.toString(),
      'name': uid.toString(),
      'sender': widget.name,
      'senderId': widget.Uid,
    });
  }

  String reciverName;

  bool isTableRecordInserted = false;

  @override
  Widget build(BuildContext context) {
    if (!isTableRecordInserted) {
      newTable();
      isTableRecordInserted = true;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "See Profile of " + widget.name,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(),
          Padding(
            padding: EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 50),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.number,
                      style: TextStyle(fontSize: 50),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.mail,
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(50),
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection('details')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (ctx, streamSnapshot) {
                  if (streamSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final document = streamSnapshot.data.documents;
                  return FutureBuilder(
                    future: FirebaseAuth.instance.currentUser(),
                    builder: (ctx, futureSnapshot) {
                      if (futureSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: Text('No Organs Uploaded'),
                        );
                      }
                      return ListView.builder(
                        reverse: true,
                        itemCount: document.length,
                        itemBuilder: (ctx, index) {
                          return OrganList(
                            document[index]['text'],
                            document[index]['userID'] == widget.Uid,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
