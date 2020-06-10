import 'package:flutter/material.dart';

import './journey.dart';

class Journeys with ChangeNotifier {
  List<Journey> _items = [
    Journey(
      jid: 'j1',
      uid: 'u1',
      from: 'Patiala',
      to: 'Jalandhar',
      date: DateTime.parse('2020-06-23'),
      withWhom: 'u2'
    ),
    Journey(
      jid: 'j2',
      uid: 'u1',
      from: 'Patiala',
      to: 'Rajsthan',
      date: DateTime.parse('2020-06-23'),
      withWhom: null
    ),
    Journey(
      jid: 'j3',
      uid: 'u1',
      from: 'Chandigarh',
      to: 'Jalandhar',
      date: DateTime.parse('2020-04-12'),
      withWhom: null
    ),
    Journey(
      jid: 'j4',
      uid: 'u1',
      from: 'Chandigarh',
      to: 'Manali',
      date: DateTime.parse('2020-04-12'),
      withWhom: null
    ),
    Journey(
      jid: 'j5',
      uid: 'u1',
      from: 'Manali',
      to: 'Shimla',
      date: DateTime.parse('2020-04-12'),
      withWhom: null
    ),
    Journey(
      jid: 'j6',
      uid: 'u2',
      from: 'Patiala',
      to: 'Jalandhar',
      date: DateTime.parse('2020-06-23'),
      withWhom: null
    ),
  ];

  List<Journey> get items {
    return [..._items];
  }

  List<Journey> get historyJourneys {
    return _items.where(
      (journey) => journey.withWhom!=null
    ).toList();
  }

  // int get countHistJourneys {
  //   List<Journey> histJourneys = _items.where(
  //     (journey) => journey.withWhom!=null
  //   ).toList();
  //   return (historyJourneys==null)? 0: histJourneys.length;
  // }

  // int get countCurrJourneys {
  //   List<Journey> currJourneys = _items.where(
  //     (journey) => journey.withWhom!=null
  //   ).toList();
  //   return (currJourneys==null)? 0: currJourneys.length;
  // }

  List<Journey> itemsUser(String id) {
    return _items.where((element) => element.uid == id).toList();
  }

  void addJourney(String uid, String from, String to, DateTime dateTime) {
    _items.add(Journey(
      jid: DateTime.now().toString(),
      uid: uid,
      from: from,
      to: to,
      date: dateTime,
      withWhom: null
    
    ));
    notifyListeners();
  }
}
