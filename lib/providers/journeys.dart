import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import './journey.dart';

class Journeys with ChangeNotifier {
  List<Journey> _items = [
    // Journey(
    //   jid: 'j1',
    //   uid: 'u1',
    //   from: 'Patiala',
    //   to: 'Jalandhar',
    //   date: DateTime.parse('2020-06-23'),
    //   withWhom: 'u2'
    // ),
    // Journey(
    //   jid: 'j2',
    //   uid: 'u1',
    //   from: 'Patiala',
    //   to: 'Rajsthan',
    //   date: DateTime.parse('2020-06-23'),
    //   withWhom: null
    // ),
    // Journey(
    //   jid: 'j3',
    //   uid: 'u1',
    //   from: 'Chandigarh',
    //   to: 'Jalandhar',
    //   date: DateTime.parse('2020-04-12'),
    //   withWhom: null
    // ),
    // Journey(
    //   jid: 'j4',
    //   uid: 'u1',
    //   from: 'Chandigarh',
    //   to: 'Manali',
    //   date: DateTime.parse('2020-04-12'),
    //   withWhom: null
    // ),
    // Journey(
    //   jid: 'j5',
    //   uid: 'u1',
    //   from: 'Manali',
    //   to: 'Shimla',
    //   date: DateTime.parse('2020-04-12'),
    //   withWhom: null
    // ),
    // Journey(
    //   jid: 'j6',
    //   uid: 'u2',
    //   from: 'Patiala',
    //   to: 'Jalandhar',
    //   date: DateTime.parse('2020-06-23'),
    //   withWhom: null
    // ),
  ];

  final String authToken;

  Journeys(this.authToken, this._items);

  List<Journey> get items {
    return [..._items];
  }

  List<Journey> get historyJourneys {
    return _items.where(
      (journey) => journey.withWhom!=null
    ).toList();
  }

  int get countHistJourneys {
    List<Journey> histJourneys = _items.where(
      (journey) => journey.withWhom==null
    ).toList();
    return (historyJourneys==null)? 0: histJourneys.length;
  }

  int get countCurrJourneys {
    List<Journey> currJourneys = _items.where(
      (journey) => journey.withWhom!=null
    ).toList();
    return (currJourneys==null)? 0: currJourneys.length;
  }

  String id;

  List<Journey> itemsUser() {
    return _items.where((element) => element.creator == id).toList();
  }

  Future<void> addJourney(String creator, String from, String to, DateTime dateTime) async {
    const url = 'http://localhost:5000/api/journeys';
    try{
      final response = await http.post(
        url, 
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken'
        },
        body: json.encode({
          "from": from,
          "to": to,
          "date": DateFormat.yMMMMd().format(dateTime)
        })
      );
      final responseData = json.decode(response.body);
      print(responseData);
      final newJourney = Journey(
        jid: responseData['journey']['_id'],
        creator: responseData['journey']['creator'],
        from: from,
        to: to,
        date: dateTime,
        withWhom: null
      );
      _items.add(newJourney);
      id = responseData['journey']['creator'];
    }catch(err){
      print(err);
      // throw err;
    }
    notifyListeners();
  }
}
