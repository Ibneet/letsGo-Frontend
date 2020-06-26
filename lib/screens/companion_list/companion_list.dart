import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../screens/chat/chat_screen.dart';
import '../../screens/companion_list/companion_detail_screen.dart';

class CompanionList extends StatelessWidget {
  final String name;
  final DateTime dob;
  final String occupation;
  final String gender;
  final String from;
  final String to;
  final DateTime date;
  
  CompanionList({
    this.name, 
    this.dob, 
    this.occupation, 
    this.gender,
    this.from,
    this.to,
    this.date
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 6,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            CompanionDetailScreen.routeName,
            arguments: {
              'name': name,
              'from': from,
              'to': to,
              'date': date
            }
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '$name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(DateFormat.yMMMd().format(dob)),
                          Text('$occupation'),
                          Text('$gender')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Material(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(ChatScreen.routeName);
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'REQUEST',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
