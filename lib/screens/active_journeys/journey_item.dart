import 'package:flutter/material.dart';

class JourneyItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Source',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                ],
              ),
              Container(
                height: 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Divider(
                      color: Colors.black,
                      height: 5,
                    ),
                    Icon(Icons.import_export),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Destination',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
