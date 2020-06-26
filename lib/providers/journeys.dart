import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import './journey.dart';
import '../models/user.dart';
import '../models/http_exception.dart';
import '../providers/companion.dart';

class Journeys with ChangeNotifier {
  final port = Platform.isIOS ? 'localhost' : '10.0.2.2';
  List<Journey> _items = [];

  List<Companion> _companions = [];

  final String _authToken;

  Journeys(this._authToken, this._items);

  List<Journey> get items {
    return [..._items];
  }

  List<Companion> get compaions {
    return [..._companions];
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
    var url = 'http://$port:5000/api/journeys/current';
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
          // creator: journey['creator'],
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
    var url = 'http://$port:5000/api/journeys';
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
        // creator: responseData['journey']['creator'],
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

  Future<void> getCompanions(String from, String to, DateTime dateTime) async {
    var url = 'http://$port:5000/api/journeys/$from/$to/${DateFormat.yMMMMd().format(dateTime)}';
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
        _companions = [];
        throw HttpException(responseData['message']);
      }
      final extractedData = responseData['companions'] as List<dynamic>;
      final List<Companion> companionsData = [];
      extractedData.forEach((companion) {
        companionsData.add(Companion(
          name: companion['companion']['name'],
          dob: DateTime.parse(companion['companion']['dob']),
          occupation: companion['companion']['occupation'],
          gender: companion['companion']['gender'],
          from: companion['from'],
          to: companion['to'],
          date: DateTime.parse(companion['date']),
        ));
      });
      print(companionsData);
      _companions = companionsData;
      notifyListeners();
    }catch(err){
      print('hi');
      throw(err);
    }
  }
}
