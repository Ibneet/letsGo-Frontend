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
    this.uid,
    this.name,
    this.phoneNumber,
    this.email,
    this.gender,
    this.occupation,
    this.imageUrl,
    this.dob,
    this.journeys
  });
}

