import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../screens/companion_list/companion_list_screen.dart';

class JourneyItem extends StatelessWidget {
  final String journeySource;
  final String journeyDestination;
  final DateTime journeyDate;
  final String journeyWith;

  JourneyItem({
    this.journeyDate,
    this.journeyDestination,
    this.journeySource,
    this.journeyWith,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 12,
      // color: Theme.of(context).accentColor,

      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            CompanionListScreen.routeName,
            arguments: {
              'from': journeySource,
              'to': journeyDestination,
              'date': journeyDate
            }
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child: Text(
                  DateFormat.yMMMd().format(journeyDate),
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          journeySource,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          height: 5,
                        ),
                        Text(
                          journeyDestination,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.import_export,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    // return Container(
    //   height: 150,
    //   margin: const EdgeInsets.symmetric(
    //     horizontal: 10,
    //     vertical: 5,
    //   ),
    //   child: InkWell(
    //     onTap: () {
    //       Navigator.of(context).pushNamed(CompanionListScreen.routeName);
    //     },
    //     child: Card(
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(16),
    //       ),
    //       elevation: 12,
    //       child: Container(
    //         padding: const EdgeInsets.all(10),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: <Widget>[
    //             Center(
    //               child: Text(
    //                 DateFormat.yMMMd().format(journeyDate),
    //                 style: TextStyle(
    //                   fontSize: 14,
    //                 ),
    //               ),
    //             ),
    //             Row(
    //               mainAxisSize: MainAxisSize.max,
    //               children: <Widget>[
    //                 Expanded(
    //                   flex: 5,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: <Widget>[
    //                       Text(
    //                         journeySource,
    //                         style: TextStyle(
    //                           fontSize: 18,
    //                           fontWeight: FontWeight.w400,
    //                         ),
    //                       ),
    //                       Divider(
    //                         color: Colors.black,
    //                         height: 5,
    //                       ),
    //                       Text(
    //                         journeyDestination,
    //                         style: TextStyle(
    //                           fontSize: 18,
    //                           fontWeight: FontWeight.w500,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Spacer(),
    //                 Expanded(
    //                   flex: 1,
    //                   child: Icon(
    //                     Icons.import_export,
    //                     size: 30,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
