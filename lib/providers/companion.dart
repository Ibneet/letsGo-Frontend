import 'package:flutter/material.dart';

class Companion with ChangeNotifier{
  final String name;
  final String from;
  final String to;
  final DateTime date;
  final DateTime dob;
  final String gender;
  final String occupation;

  Companion({
    @required this.name,
    @required this.from,
    @required this.to,
    @required this.date,
    @required this.dob,
    @required this.gender, 
    @required this.occupation,
  });
}