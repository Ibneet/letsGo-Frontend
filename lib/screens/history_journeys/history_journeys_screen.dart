import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/journeys.dart';
import './history_grid.dart';

class HistoryJourneysScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final journeysData = Provider.of<Journeys>(context);
    final journeys = journeysData.items;
    final historyJourneys = journeys.where(
      (journey){
        return journey.withWhom!=null;
      }
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('History Journeys'),
      ),

      body: (historyJourneys.length==0)
      ?Center(child: Text('No journey completed yet!'),)

      :HistoryGrid(historyJourneys)
    );
  }
}

