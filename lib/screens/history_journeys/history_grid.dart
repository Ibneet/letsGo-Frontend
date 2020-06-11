import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/journey.dart';

import './history_journeys_list.dart';

class HistoryGrid extends StatelessWidget {
  final List<Journey> historyJourneys;

  HistoryGrid(this.historyJourneys);
 
  @override
  Widget build(BuildContext context) {

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: historyJourneys.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: historyJourneys[i],
        child: HistoryJourneysList(
          historyJourneys[i].jid, 
          historyJourneys[i].from, 
          historyJourneys[i].to, 
          historyJourneys[i].date,
          historyJourneys[i].withWhom
        ),
      ), 

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ), 
      
    );
  }
}