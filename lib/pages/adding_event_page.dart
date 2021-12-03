import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AddingEvent extends StatefulWidget {
  static const routeName = '/addevent';
  @override
  _AddingEventState createState() => _AddingEventState();
}

class _AddingEventState extends State<AddingEvent> {
  File _image;
  final imagePicker = ImagePicker();
  String downloardedURL;

  final _descriptionFocus = FocusNode();
  final _datetime = FocusNode();
  final _placevent = FocusNode();
  final _event = GlobalKey<FormState>();

  var _eventName = '';
  var _description = '';
  var _dateTime = '';
  var _place = '';

  @override
  void dispose() {
    _descriptionFocus.dispose();
    _datetime.dispose();
    _placevent.dispose();
    super.dispose();
  }

  Future ImagePickerMethod() async {
    final pick = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar(
          "No file selected",
          Duration(
            milliseconds: 400,
          ),
        );
      }
    });
  }

// Upload Image

  Future UploadImage() async {
    StorageReference ref = FirebaseStorage.instance.ref().child("Events");
    await ref.putFile(_image);
    downloardedURL = await ref.getDownloadURL();
    print(downloardedURL);

// uploading to cloud fire store
    final isValid = _event.currentState.validate();

    if (isValid)
      Firestore.instance.collection('events').add({
        'name': _eventName,
        'dis': _description,
        'date': _dateTime,
        'text': _place,
        'image': downloardedURL,
      });
    Navigator.of(context).pop();
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
        title: Text('Add Your Event'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _event,
          child: ListView(
            children: <Widget>[
              Divider(),
              TextFormField(
                decoration: InputDecoration(labelText: 'Event Name'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Provide the Event Name';
                  }
                  return null;
                },
                onChanged: (value) {
                  _eventName = value;
                },
              ),
              Divider(),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_datetime);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter Some Description about the Event';
                  }
                  if (value.length < 10) {
                    return 'Please enter some long Description';
                  }
                  return null;
                },
                onChanged: (value) {
                  _description = value;
                },
              ),
              Divider(),
              TextFormField(
                  decoration: InputDecoration(labelText: 'Date & Time'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _datetime,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_placevent);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter the Date & Time';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _dateTime = value;
                  }),
              Divider(),
              TextFormField(
                  decoration: InputDecoration(labelText: 'Place of the Event'),
                  textInputAction: TextInputAction.next,
                  focusNode: _placevent,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter the place of Event';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _place = value;
                  }),
              Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.black54,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    child: _image == null
                        ? const Center(
                            child: Text("No Image Selected"),
                          )
                        : Image.file(_image),
                  ),
                  Positioned(
                    top: 20,
                    child: Builder(
                      builder: (ctx) => Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              ImagePickerMethod();
                            },
                            child: Text("Select Image"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_image != null) {
                                UploadImage().whenComplete(
                                  () => showSnackBar(
                                    "Event Posted Successfully",
                                    Duration(
                                      seconds: 2,
                                    ),
                                  ),
                                );
                              } else {
                                showSnackBar(
                                  "Select Image First",
                                  Duration(seconds: 1),
                                );
                              }
                            },
                            child: Text("Post"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
