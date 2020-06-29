import 'package:flutter/material.dart';

import './active_journeys/active_journeys_screen.dart';
import './history_journeys/history_journeys_screen.dart';

class JourneysScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Journeys'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Previous',)
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ActiveJourneysScreen(),
            HistoryJourneysScreen()
          ],
        ),
      ),
    );
  }
}