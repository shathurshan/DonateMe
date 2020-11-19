import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DonorSerWid extends StatefulWidget {
  static const routeName = '/serdonowid';

  final Uid;
  final name;
  final number;
  final mail;

  DonorSerWid(
    this.Uid,
    this.name,
    this.number,
    this.mail,
  );

  @override
  _DonorSerWidState createState() => _DonorSerWidState();
}

class _DonorSerWidState extends State<DonorSerWid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.mail,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 100.0,
            ),
          ),
          SizedBox(),
          Padding(
            padding: EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 50),
                  textAlign: TextAlign.end,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      widget.number,
                      style: TextStyle(fontSize: 50),
                    ),
                    // FlatButton.icon(
                    //   onPressed: () {},
                    //   icon: Icon(Icons.call),
                    //   label: Text(
                    //     'Contect',
                    //     overflow: TextOverflow.fade,
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.mail,
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
