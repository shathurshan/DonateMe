

import 'package:flutter/material.dart';


class EventWid extends StatelessWidget {
  final String id;
  final String eventName;
  final String date;
  final String description;
  final String place;
  final String imageUrl;

  EventWid(
      this.id,
      this.eventName,
      this.date,
      this.description,
      this.place,
      this.imageUrl,
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child:
        Column(
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
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
//                  right: 10,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: 200,
                    color: Colors.white,
                    child:ListTile(
                      title: Text(eventName),
                      subtitle: Text(description),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
//                  right: 10,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: 220,
                    color: Colors.white,
                    child:ListTile(
                      title: Text(date),
                      subtitle: Text(place),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
