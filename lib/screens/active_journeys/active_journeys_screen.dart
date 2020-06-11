import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './journey_item.dart';
import './add_new_journey.dart';
import '../../providers/journeys.dart';
import '../../screens/companion_list/companion_list_screen.dart';

class ActiveJourneysScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var journeys = Provider.of<Journeys>(context);
    var journeysData = journeys.itemsUser('u1');
    var appHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Want A Companion'),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: appHeight * .25,
            color: Theme.of(context).primaryColor,
            // decoration: BoxDecoration(),
            child: AddNewJourney(),
          ),
          Expanded(
            child: ListWheelScrollView(
              // onSelectedItemChanged: (index) {
              //   return () {
              //     Navigator.of(context)
              //         .pushNamed(CompanionListScreen.routeName);
              //   };
              // },
              itemExtent: 160,
              diameterRatio: 5,
              children: journeysData.map(
                (journey) {
                  return JourneyItem(
                    journeyDate: journey.date,
                    journeyDestination: journey.to,
                    journeySource: journey.from,
                    journeyWith: journey.withWhom,
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
      // body: CustomScrollView(
      //   slivers: <Widget>[
      //     SliverAppBar(
      //       title: Container(
      //         width: double.infinity,
      //         height: appHeight * 0.05,
      //         child: const Text('Want A Companion'),
      //       ),
      //       pinned: true,
      //       expandedHeight: appHeight * .3,
      //       flexibleSpace: FlexibleSpaceBar(
      //         background: AddNewJourney(),
      //       ),
      //     ),
      //     SliverGrid(
      //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 2,
      //         childAspectRatio: 3 / 2,
      //         crossAxisSpacing: 15,
      //         mainAxisSpacing: 15,
      //       ),
      //       delegate: SliverChildBuilderDelegate(
      //         (ctx, index) => JourneyItem(
      //           journeyDate: journeysData[index].date,
      //           journeyDestination: journeysData[index].to,
      //           journeySource: journeysData[index].from,
      //           journeyWith: journeysData[index].withWhom,
      //         ),
      //         childCount: journeysData.length,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
