import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../dummy_data.dart';

class HistoryJourneysList extends StatelessWidget {
  final String jid;
  final String from;
  final String to;
  final DateTime date;
  final String withWhom;

  HistoryJourneysList(this.jid, this.from, this.to,this.date, this.withWhom);

  @override
  Widget build(BuildContext context) {
    final imageUrl = dummyUsers.singleWhere(
      (user) {
        if(user.uid == withWhom){
          return true;
        }
        return false;
      }
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: Image.network(
          imageUrl.imageUrl,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            '$from - $to',
            style: Theme.of(context).textTheme.headline1,
          ),
          subtitle: Text(DateFormat.yMMMEd().format(date)),
        ),
      ),
    );
  }
}