import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
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
          query = " ";
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
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Card(
      child: Text(query),
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
    throw UnimplementedError();
  }
}
