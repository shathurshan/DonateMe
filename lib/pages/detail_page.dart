
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
//  final String title;
//
//  DetailPage(this.title);

  static const routeName = '/detail';


  @override
  Widget build(BuildContext context) {
    final Frontid = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("Title", textAlign: TextAlign.center,),
        centerTitle: true,
      ),
    );
  }
}
