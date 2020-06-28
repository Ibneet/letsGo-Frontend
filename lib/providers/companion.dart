import 'package:flutter/material.dart';

class Companion with ChangeNotifier {
  final String jid;
  final String toId;
  final String name;
  final String from;
  final String to;
  final DateTime date;
  final DateTime dob;
  final String gender;
  final String occupation;

  Companion({
    this.jid,
    this.toId,
    this.name,
    this.from,
    this.to,
    this.date,
    this.dob,
    this.gender,
    this.occupation,
  });
}
