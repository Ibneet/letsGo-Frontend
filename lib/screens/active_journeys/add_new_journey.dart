import 'package:flutter/material.dart';

import './DataSearch.dart';

class AddNewJourney extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var appHeight = mediaQuery.size.height - mediaQuery.padding.top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: appHeight * 0.1,
      ),
      height: appHeight * .4,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              height: appHeight * 0.075,
              child: Card(
                elevation: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      Icons.my_location,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: mediaQuery.size.width * 0.5,
                      child: Text(
                        'Source',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              height: appHeight * 0.075,
              child: Card(
                elevation: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      Icons.pin_drop,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: mediaQuery.size.width * 0.5,
                      child: const Text(
                        'Destination',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
