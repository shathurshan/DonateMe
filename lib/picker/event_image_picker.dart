import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EventImagePicker extends StatefulWidget {
  @override
  _EventImagePickerState createState() => _EventImagePickerState();
}

class _EventImagePickerState extends State<EventImagePicker> {
  File _picedImageCam;
  File _picedImagegal;
  final picker = ImagePicker();

  void _pickImage() async {
    final _picedImageFile = await picker.getImage(source: ImageSource.camera);
    setState(
      () {
        _picedImageCam = File(_picedImageFile.path);
      },
    );
  }

  void _getImage() async {
    final _getImageFile = await picker.getImage(source: ImageSource.gallery);
    setState(
      () {
        _picedImagegal = File(_getImageFile.path);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
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
                    ? FileImage(_picedImagegal)
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
                                'Gallery',
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
    );
  }
}
