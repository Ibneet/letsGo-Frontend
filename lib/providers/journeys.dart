import 'package:flutter/material.dart';

import './journey.dart';

class Journeys with ChangeNotifier{
  List<Journey> _items = [
    Journey(
    jid: 'j1',
    uid: 'u1',
    from: 'Patiala',
    to: 'Jalandhar',
    date: DateTime.parse('2020-06-23'),
    withWhom: 'u3'
  ),
  Journey(
    jid: 'j2',
    uid: 'u3',
    from: 'Patiala',
    to: 'Jalandhar',
    date: DateTime.parse('2020-06-23'),
    withWhom: null
  ),
  Journey(
    jid: 'j3',
    uid: 'u2',
    from: 'Chandigarh',
    to: 'Jalandhar',
    date: DateTime.parse('2020-04-12'),
    withWhom: null
  ),
  Journey(
    jid: 'j4',
    uid: 'u4',
    from: 'Chandigarh',
    to: 'Jalandhar',
    date: DateTime.parse('2020-04-12'),
    withWhom: null
  ),
  Journey(
    jid: 'j5',
    uid: 'u5',
    from: 'Chandigarh',
    to: 'Jalandhar',
    date: DateTime.parse('2020-04-12'),
    withWhom: null
  )
];

  List<Journey> get items {
    return [..._items];
  }

  void addJourney() {
    // _items.add(value);
    notifyListeners();
  }
}