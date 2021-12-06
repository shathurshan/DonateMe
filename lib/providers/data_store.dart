import 'package:flutter/material.dart';
import '../items/front_page_item.dart';

class Data with ChangeNotifier {
  List<Front> _items = [
    Front(
      id: 'c1',
      logins: [
        'm1',
        'm2',
      ],
      title: 'Rules',
      imageUrl: 'images/new.jpg',
      url: 'http://www.nbts.health.gov.lk/index.php/donate-blood',
    ),
    Front(
      id: 'c2',
      logins: [
        'm1',
        'm2',
      ],
      title: 'Disadvantages',
      imageUrl: 'images/2.jpg',
      url: 'https://www.healthline.com/health/disadvantages-blood-donation',
    ),
    Front(
      id: 'c3',
      logins: [
        'm1',
        'm2',
      ],
      title: 'Advantages',
      imageUrl: 'images/3.jpg',
      url:
          'https://www.healthline.com/health/benefits-of-donating-blood#donation-procedure',
    ),
  ];

  List<Front> get items {
    return [..._items];
  }

  void addLogin() {
    notifyListeners();
  }

  void addFront() {
    notifyListeners();
  }
}
