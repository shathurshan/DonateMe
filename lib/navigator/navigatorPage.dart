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
        title: Text('Be a God For Need'),
        centerTitle: true,
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            UserNavigation().accessUser(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
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
      drawer: AppDrawerWid(),
    );
  }
}
//