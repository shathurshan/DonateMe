import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrganList extends StatelessWidget {

  static const routeName = "/list";

  OrganList(this.organ, this.isMe);

  final String organ;
  final bool isMe;


  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return isMe ? Card(
          elevation: 5,
          color: Colors.redAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                    organ,
                    style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      DateFormat.yMd().format(
                        DateTime.now(),
                      ),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ): CircularProgressIndicator();
  }
}
