import 'package:flutter/material.dart';

import '../screens/active_journeys/active_journeys_screen.dart';
import '../screens/history_journeys/history_journeys_screen.dart';
import '../screens/chat/chat_screen.dart';
import '../screens/user_profile/user_profile_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  
  final List<Widget> _screens = [
    ActiveJourneysScreen(),
    HistoryJourneysScreen(),
    ChatScreen(),
    UserProfileScreen()
  ];
  int _selectedScreenIndex = 0;

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectScreen,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedScreenIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on), title: Text('Active')),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), title: Text('History')),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat), title: Text('Chat')),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_pin), title: Text('Profile')),
          ]),
    );
  }
}
