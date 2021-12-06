import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutternew/picker/event_image_picker.dart';
import 'package:flutternew/profile/profile_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfile extends StatefulWidget {
  static const routeName = '/editprofile';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  final _formKey = GlobalKey<FormState>();
  String _userMail = '';
  var _userName = '';
  var _userPassword = '';
  var _userType = '';
  var _userNumber = '';

  bool _isLoading = false;
  void _submitFn(
    String username,
    String email,
    String password,
    String type,
    String number,
  ) async {
    bool isUserIdFetched = false;
    String userId;
    final user = FirebaseAuth.instance.currentUser();
    var collection = Firestore.instance.collection('user');
    user.then((value) {
      collection
          .document(value.uid)
          .updateData({
            "username": _userName,
            'contact number': _userNumber,
            'type of user': type,
            'email': _userMail
          })
          .then((_) => print('Success'))
          .catchError((error) => print('Failed: $error'));
    });
  }

  User userForUpdate;

  void _updateProfile() {
    final isValid = _formKey.currentState.validate();

    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      _submitFn(
        _userName.trim(),
        _userMail.trim(),
        _userPassword.trim(),
        _userType.trim(),
        _userNumber.trim(),
      );
    }

    Navigator.of(context).pop();
    showSnackBar(
      "Profile Updated Successfuly",
      Duration(
        seconds: 2,
      ),
    );
  }

  bool isDataFetched = false;
  void getUsers() async {
    setState(() {
      isDataFetched = false;
    });
    String userId;
    final user = FirebaseAuth.instance.currentUser();
    user.then((value) {
      setState(() {
        userId = value.uid;
      });
    });
    var docs = await Firestore.instance.collection('user').getDocuments();
    docs.documents.forEach((element) {
      if (element['uid'] == userId) {
        setState(() {
          _userMail = element['email id'];
          _userName = element['username'];
          _userType = element['type of user'];
          _userNumber = element['contact number'];
        });
      }
    });
    setState(() {
      isDataFetched = true;
    });
  }

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(
      content: Text(snackText),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: isDataFetched
                ? SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextFormField(
                            initialValue: _userName,
                            validator: (value) {
                              if (value.isEmpty || value.length < 5) {
                                return 'Enter minimum of 5 character User Name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                            ),
                            onSaved: (value) {
                              _userName = value;
                            },
                          ),
                          TextFormField(
                            initialValue: _userMail,
                            key: ValueKey('email'),
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return 'Please Enter some Valid Email Address.';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                            ),
                            onSaved: (value) {
                              _userMail = value;
                            },
                          ),
                          TextFormField(
                            initialValue: _userType,
                            key: ValueKey('type'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please chose a Type of User';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Register as(Donor/Recipient*)',
                            ),
                            onSaved: (value) {
                              setState(() {
                                _userType = value;
                              });
                            },
                          ),
                          TextFormField(
                            initialValue: _userNumber,
                            key: ValueKey('number'),
                            validator: (value) {
                              if (value.isEmpty || value.length < 10) {
                                return 'Enter some valid Mobile Number';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Mobile Number',
                            ),
                            onSaved: (value) {
                              _userNumber = value;
                            },
                          ),
                          SizedBox(height:8),
                          RaisedButton(
                            child: Text('Update Profile'),
                            onPressed: _updateProfile,
                          ),
                          SizedBox(height:12),
                        ],
                      ),
                    ),
                )
                : Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}

class User {
  String username;
  String email;
  String password;
  String type;
  String number;

  User(
      {@required this.username,
      @required this.email,
      @required this.type,
      @required this.number});
}
