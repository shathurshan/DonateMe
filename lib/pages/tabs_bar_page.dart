import 'package:flutter/material.dart';

import 'invite_page.dart';
import 'notificaton_page.dart';
import '../profile/profile_page.dart';
import 'front_page.dart';

class TabsPage extends StatefulWidget {
  static const routeName = '/tabs';

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final List<Widget> _pages = [
    FrontPage(),
    InvitePage(),
    NotificationPage(),
    ProfilePage(),
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.black,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'FontWeight.bold',
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group,
              color: Colors.white,
            ),
            title: Text(
              'Invite',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'FontWeight.bold',
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            title: Text(
              'Notification',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'FontWeight.bold',
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'FontWeight.bold',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
