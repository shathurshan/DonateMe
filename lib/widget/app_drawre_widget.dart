import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/events_page.dart';

class AppDrawerWid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Donate Before Die'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.event),
            title: Text('Events'),
            onTap: () {
              Navigator.of(context).pushNamed(EventsPage.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('LogOut'),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
