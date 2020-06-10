import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './journey_item.dart';
import './add_new_journey.dart';
import '../../providers/journeys.dart';

class ActiveJourneysScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var journeys = Provider.of<Journeys>(context);
    var journeysData = journeys.items;
    var appHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Container(
              width: double.infinity,
              height: appHeight * 0.05,
              child: const Text('Want A Companion'),
            ),
            pinned: true,
            expandedHeight: appHeight * .25,
            flexibleSpace: FlexibleSpaceBar(
              background: AddNewJourney(),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            delegate: SliverChildBuilderDelegate(
              (ctx, index) => JourneyItem(
                journeyDate: journeysData[index].date,
                journeyDestination: journeysData[index].to,
                journeySource: journeysData[index].from,
              ),
              childCount: journeysData.length,
            ),
          ),
        ],
      ),
    );
  }
}
