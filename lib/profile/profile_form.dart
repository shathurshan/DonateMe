import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileForm extends StatefulWidget {
  static const routeName = '/proform';

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _controler = TextEditingController();
  var _enterOrgan = '';
   void addOrgan() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('details').add({
      'text': _enterOrgan,
      'time': Timestamp.now(),
      'userID': user.uid,
    });
    _controler.clear();
    Navigator.of(context).pop();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AlertDialog(
        title: Text('Donated Organ'),
        content: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: _controler,
            decoration: InputDecoration(
              labelText: 'Which Organ you Want to Add?',
            ),
            onChanged: (val) {
              _enterOrgan = val;
            },
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: addOrgan,
          ),
          FlatButton(
            child: Text('Back'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
