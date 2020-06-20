import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import './journey.dart';
import '../models/http_exception.dart';

class Journeys with ChangeNotifier {
  List<Journey> _items = [];

  final String _authToken;

  Journeys(this._authToken, this._items);

  List<Journey> get items {
    return [..._items];
  }

  String get authToken {
    return _authToken;
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

  Future<void> getActiveJourneys() async {
    const url = 'http://localhost:5000/api/journeys/current';
    try{
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $authToken'
        },
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if(responseData['message'] != null){
        _items = [];
        throw HttpException(responseData['message']);
      }
      final extractedData = responseData['journey'] as List<dynamic>;
      final List<Journey> journeyData = [];
      extractedData.forEach((journey) {
        journeyData.add(Journey(
          jid: journey['_id'],
          from: journey['from'],
          to: journey['to'],
          date: DateTime.parse(journey['date']),
          creator: journey['creator'],
          withWhom: journey['withWhom']
        ));
      });
      _items = journeyData;
      // print(responseData['journey']);
      notifyListeners();
    }catch(err){
      throw(err);
    }
  }

  Future<void> addJourney(String from, String to, DateTime dateTime) async {
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
      if(responseData['message'] != null){
        throw HttpException(responseData['message']);
      }
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
      notifyListeners();
    }catch(err){
      throw err;
    }
  }
}
