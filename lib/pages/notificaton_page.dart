import 'package:flutter/material.dart';

import 'package:flutternew/widget/app_drawre_widget.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Notification'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'The Notification options will Show soon',
        ),
      ),
      drawer: AppDrawerWid(),
    );
  }
}
