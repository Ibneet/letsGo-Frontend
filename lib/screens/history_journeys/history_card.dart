import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../dummy_data.dart';

class HistoryCard extends StatelessWidget {
  final String jid;
  final String from;
  final String to;
  final DateTime date;
  final String withWhom;
  final bool active;

  HistoryCard(
      this.jid, this.from, this.to, this.date, this.withWhom, this.active);

  @override
  Widget build(BuildContext context) {
    final double blur = active ? 80 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;
    final double bottom = active ? 60 : 100;

    // final imageUrl = dummyUsers.singleWhere((user) {
    //   if (user.uid == withWhom) {
    //     return true;
    //   }
    //   return false;
    // });
    final imageUrl =
        'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';

    return AnimatedContainer(
      duration: Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeInOutQuint,
      margin: EdgeInsets.only(
        top: top,
        bottom: bottom,
        right: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(
            imageUrl,
            // imageUrl.imageUrl,
          ),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            blurRadius: blur,
            offset: Offset(offset, offset),
          ),
        ],
      ),
      // child: Container(
      //     margin: EdgeInsets.only(
      //       top: top,
      //       bottom: bottom,
      //       right: 10,
      //     ),
      //     decoration: BoxDecoration(
      //       color: Colors.black87,
      //     ),
      //     child: Column(
      //       children: <Widget>[
      //         Text(
      //           '$from - $to',
      //           style: Theme.of(context).textTheme.headline1,
      //         ),
      //         Text(
      //           DateFormat.yMMMEd().format(date),
      //           style: Theme.of(context).textTheme.headline1,
      //         ),
      //       ],
      //     )),
    );
  }
}
