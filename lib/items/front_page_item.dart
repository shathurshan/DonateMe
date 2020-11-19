import 'package:flutter/material.dart';

class Front {
  final String id;
  final List<String> logins;
  final String title;
  final String imageUrl;
  final String url;

  const Front({
    @required this.id,
    @required this.logins,
    @required this.title,
    @required this.imageUrl,
    @required this.url,
  });
}
