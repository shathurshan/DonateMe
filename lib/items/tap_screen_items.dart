import 'package:flutter/material.dart';

class Tap {
  final String id;
  final String title;
  final List<String> fronts;
  final String info;

  const Tap({
    @required this.id,
    @required this.title,
    @required this.fronts,
    @required this.info,
  });
}
