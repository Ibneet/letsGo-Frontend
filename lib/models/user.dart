import 'package:flutter/material.dart';

class User{
  final String uid;
  final String name;
  final String gender;
  final String occupation;
  final String imageUrl;
  final DateTime dob;
  List<String> journeys;

  User({
    @required this.uid,
    @required this.name,
    @required this.gender,
    @required this.occupation,
    @required this.imageUrl,
    @required this.dob,
    this.journeys
  });
}

