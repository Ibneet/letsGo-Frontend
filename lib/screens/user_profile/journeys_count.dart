import 'package:flutter/material.dart';

class JourneyCount extends StatelessWidget {
  final int countCurrent;
  final int countHistory;

  JourneyCount(this.countCurrent, this.countHistory);

  Widget counts(context, count, title){
    return Column(
      children: <Widget>[
        Container(
                height:
                    MediaQuery.of(context).size.height *
                        0.1,
                padding:
                    EdgeInsets.symmetric(horizontal: 4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          Theme.of(context).accentColor,
                      width: 2,
                    )
                    // gradient: LinearGradient(
                    //     colors: [
                    //       Colors.pink[100],
                    //       Colors.purple[200],
                    //       Colors.cyan,
                    //       Colors.lightBlue[200]
                    //     ],
                    //     begin: Alignment.topLeft,
                    //     end: Alignment.bottomRight),
                    ),
                width: MediaQuery.of(context).size.width *
                    0.5,
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'GentiumBookBasic',
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'GentiumBookBasic',
                  color: Colors.white
                )
              )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          counts(context, countCurrent, 'Current journeys'),
          counts(context, countHistory, 'History journeys'),
        ],
      ),
    );
  }
}
