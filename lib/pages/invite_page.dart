import 'package:flutter/material.dart';
import 'package:flutternew/widget/app_drawre_widget.dart';

class InvitePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(
          'Invite',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'The Invite options will Show soon',
        ),
      ),
      drawer: AppDrawerWid(),
    );
  }
}
