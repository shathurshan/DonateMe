import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AddingEvent extends StatefulWidget {
  static const routeName = '/addevent';

  File image;

  @override
  _AddingEventState createState() => _AddingEventState();
}

class _AddingEventState extends State<AddingEvent> {
  File _picedImageCam;
  File _picedImagegal;
  final picker = ImagePicker();

  void _pickImage() async {
    final picedImageFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _picedImageCam = File(picedImageFile.path);
    });
  }

  void _getImage() async {
    final _getImageFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _picedImagegal = File(_getImageFile.path);
    });
  }

  final _descriptionFocus = FocusNode();
  final _datetime = FocusNode();
  final _placevent = FocusNode();
  final _imageUrlController = TextEditingController();
  final _event = GlobalKey<FormState>();

  var _eventName = '';
  var _description = '';
  var _dateTime = '';
  var _place = '';
  File image;

  @override
  void dispose() {
    _descriptionFocus.dispose();
    _datetime.dispose();
    _placevent.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveEvent() {
    final isValid = _event.currentState.validate();

    if(isValid)
    Firestore.instance.collection('events').add({
      'name': _eventName,
      'dis': _description,
      'date': _dateTime,
      'text': _place,
      'image': _picedImagegal.toString(),
    });
    Navigator.of(context).pop();
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
                    //..... hv to add some valid date model & style
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
//              Container(
//                height: 300,
//                width: double.infinity,
//                child: EventImagePicker(),
//              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.black54,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    child: _picedImageCam != null
                        ? Image.file(_picedImageCam)
                        : _picedImagegal != null
                            ? Image.file(_picedImagegal)
                            : null,
                  ),
                  Positioned(
                    top: 20,
                    child: Builder(
                      builder: (ctx) => FlatButton.icon(
                        onPressed: () {
                          Scaffold.of(ctx).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.black54,
                              content: Expanded(
                                child: Row(
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
                                        'Galery',
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.add_a_photo),
                        label: Text('Choose a image'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.local_post_office,
        ),
        onPressed: _saveEvent,
        backgroundColor: Colors.pink,
      ),
    );
  }
}
