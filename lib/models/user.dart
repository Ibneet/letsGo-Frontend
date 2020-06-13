import 'package:flutter/material.dart';

class User{
  final String uid;
  String name;
  String phoneNumber;
  String email;
  String gender;
  String occupation;
  String imageUrl;
  final DateTime dob;
  List<String> journeys;

  User({
    @required this.uid,
    @required this.name,
    @required this.phoneNumber,
    @required this.email,
    @required this.gender,
    @required this.occupation,
    @required this.imageUrl,
    @required this.dob,
    this.journeys
  });
}

