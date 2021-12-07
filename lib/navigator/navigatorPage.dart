import 'package:flutter/material.dart';

import 'package:flutternew/navigator/serviceNav.dart';

import 'package:flutternew/widget/app_drawre_widget.dart';

class NavigatorPage extends StatefulWidget {
  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GIVE THE GIFT OF LIFE'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 400,
            height: 400,
            child: Center(
              widthFactor: double.infinity,
              child: Image.asset("images/appstore1.jpg"),
            ),
          ),
          Container(
            width: 300,
            child: Center(
              child: RaisedButton(
                onPressed: () {
                  UserNavigation().accessUser(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.arrow_forward),
                    Text(
                      'Continue',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawerWid(),
    );
  }
}
//