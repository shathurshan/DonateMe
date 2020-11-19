import 'package:flutter/material.dart';

import '../widget/app_drawre_widget.dart';
import 'search_by_Donor.dart';

class FrontRecipentPage extends StatefulWidget {
  static const routeName = '/frontrecipi';

  @override
  _FrontRecipentPageState createState() => _FrontRecipentPageState();
}

class _FrontRecipentPageState extends State<FrontRecipentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Recipient'),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
              child: Container(
                color: Theme.of(context).primaryColor,
                height: 200,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: FlatButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(DonorSearch.routeName);
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Search in Donor',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              child: Container(
                color: Theme.of(context).primaryColor,
                alignment: Alignment.center,
                height: 200,
                padding: EdgeInsets.all(10),
                child: FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.youtube_searched_for,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Search via Map',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: AppDrawerWid(),
    );
  }
}
