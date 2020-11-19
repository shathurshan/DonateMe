import 'package:flutter/material.dart';

import '../widget/app_drawre_widget.dart';
import '../widget/front_page_widget.dart';
import 'package:provider/provider.dart';
import '../providers/data_store.dart';

import 'package:firebase_messaging/firebase_messaging.dart';


class FrontPage extends StatefulWidget {
  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override

  void initState() {
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(
      onMessage: (msg) {
        print(msg);
        return;
      },
      onLaunch: (msg) {
        print(msg);
        return;
      },
      onResume: (msg) {
        print(msg);
        return;
      },
    );
    super.initState();
  }

  Widget build(BuildContext context) {
    final FrontData = Provider.of<Data>(context);
    final fronts = FrontData.items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: fronts.length,
        itemBuilder: (context, index) => FrontWid(
          fronts[index].id,
          fronts[index].title,
          fronts[index].imageUrl,
          fronts[index].url,
        ),
      ),
      drawer: AppDrawerWid(),
    );
  }
}
