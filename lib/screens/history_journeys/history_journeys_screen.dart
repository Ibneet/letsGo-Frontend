import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/journeys.dart';
import './history_grid.dart';

class HistoryJourneysScreen extends StatefulWidget {
  
  @override
  _HistoryJourneysScreenState createState() => _HistoryJourneysScreenState();
}

class _HistoryJourneysScreenState extends State<HistoryJourneysScreen> {
  @override
  Widget build(BuildContext context) {
    final journeysData = Provider.of<Journeys>(context);
    final journeys = journeysData.historyJourneys;

    return Scaffold(
      appBar: AppBar(
        title: Text('History Journeys'),
      ),

      body: (journeys.length==0)
      ?Center(child: Text('No journey completed yet!'),)

      :HistoryGrid(journeys)
    );
  }
}

