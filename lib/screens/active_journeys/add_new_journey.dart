import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/journeys.dart';

class AddNewJourney extends StatefulWidget {
  @override
  _AddNewJourneyState createState() => _AddNewJourneyState();
}

class _AddNewJourneyState extends State<AddNewJourney> {
  String _source = 'Source';
  String _destination = 'Destination';
  DateTime _date;

  void initState() {
    setState(() {
      _source = 'Source';
      _destination = 'Destination';
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Function _addJourney =
        Provider.of<Journeys>(context, listen: false).addJourney;

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
                delegate: DataSearch(_source),
              ).then((result) {
                setState(() {
                  _source = result;
                  print(_source);
                });
              });
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
                        '$_source',
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
                delegate: DataSearch(_destination),
              ).then((result) {
                setState(() {
                  _destination = result;
                  print(_source);
                });
              });
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
                      child: Text(
                        '$_destination',
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

class DataSearch extends SearchDelegate<String> {
  final String place;

  DataSearch(this.place);
  final cities = [
    "mumbai",
    "patiala",
    "jalandhar",
    'beawar',
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, query);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // return close(context,query);
    return GestureDetector(
      onTap: () {
        close(context, this.query);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show when someone searches
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.location_city),
          title: Text(cities[0]),
        ),
      ],
    );
  }
}
