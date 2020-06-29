import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

import './journeys_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/chat/chat_user_screen.dart';
import '../screens/user_profile/user_profile_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    JourneysScreen(),
    ChatUserScreen(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        onTap: _selectScreen,
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        fabLocation: BubbleBottomBarFabLocation.end, //new
        hasNotch: true,
        hasInk: true,
        inkColor: Colors.black12, //optional, uses
        // backgroundColor: Theme.of(context).primaryColor,
        // unselectedItemColor: Colors.white,
        // selectedItemColor: Theme.of(context).accentColor,
        // type: BottomNavigationBarType.fixed,
        currentIndex: _selectedScreenIndex,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.home,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(
                Icons.swap_vertical_circle,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.swap_vertical_circle,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("Journeys")),
          BubbleBottomBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(
                Icons.chat,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.chat,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("Chat")),
          BubbleBottomBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(
                Icons.person_pin,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.person_pin,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("Profile"))
        ],
      ),
    );
  }
}
