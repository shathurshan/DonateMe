import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class FrontWid extends StatefulWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String url;

  FrontWid(this.id, this.title, this.imageUrl, this.url);

  static const routeName = 'front';

  @override
  _FrontWidState createState() => _FrontWidState();
}

class _FrontWidState extends State<FrontWid> {
  _lunchUrl() async {
    if (await canLaunch(widget.url)) {
      await launch(widget.url);
    } else {
      throw 'Could not Launch the URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _lunchUrl();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    widget.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.red,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
