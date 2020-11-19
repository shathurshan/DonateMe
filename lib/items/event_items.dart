import 'package:flutter/material.dart';

class EventItems {
  final String id;
  final String eventName;
  final String date;
  final String description;
  final String place;
  final String imageUrl;

  const EventItems({
    @required this.id,
    @required this.eventName,
    @required this.date,
    @required this.description,
    @required this.place,
    @required this.imageUrl,
  });
}
