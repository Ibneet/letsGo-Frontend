import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../providers/journeys.dart';
import '../../dummy_data.dart';
import './draggable_sheet.dart';

class UserProfileScreen extends StatelessWidget {
  final User currentUser = dummyUsers.singleWhere((user) {
    return user.uid == 'u1';
  });

  @override
  Widget build(BuildContext context) {
    final journeysData = Provider.of<Journeys>(context);
    final int countCurrent = journeysData.countCurrJourneys;
    final int countHistory = journeysData.countHistJourneys;

    final appHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: appHeight,
            child: Image.network(
              currentUser.imageUrl,
              fit: BoxFit.cover,
            ),
          ),

          DraggableSheet(
            currentUser, 
            countCurrent, 
            countHistory
          )
        ],
      ),
    );
  }
}

