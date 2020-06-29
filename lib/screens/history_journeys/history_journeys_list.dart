import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../dummy_data.dart';

class HistoryJourneysList extends StatelessWidget {
  final String jid;
  final String from;
  final String to;
  final DateTime date;

  HistoryJourneysList(this.jid, this.from, this.to, this.date);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: Image.network(
          'https://pm1.narvii.com/6707/89127fd49ab28bed5009b4a0dee5d08fcd26bd4b_hq.jpg',
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
