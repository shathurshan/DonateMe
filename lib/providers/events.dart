import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../items/event_items.dart';

class Events with ChangeNotifier {
  List<EventItems> _items = [
    EventItems(
      id: 'e1',
      eventName: 'Blood Donation Camp',
      date: "11111",
      description: 'Give your Blood for make World healthy',
      place: 'Hatton',
      imageUrl: 'images/2.jpg',
    ),
  ];

  List<EventItems> get items {
    return [..._items];
  }

  void addEventItems(EventItems eventItems) {
    final newEvent = EventItems(
      eventName: eventItems.eventName,
      description: eventItems.description,
      date: eventItems.date,
      place: eventItems.place,
      imageUrl: eventItems.imageUrl,
      id: DateTime.now().toString(),
    );
    _items.add(newEvent);
//    _items.insert(0, newEvent);
    notifyListeners();
  }

  void addEvents() {
    notifyListeners();
  }
}
