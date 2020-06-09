import 'package:flutter/material.dart';

class Journey{
  final String jid;
  final String uid;
  final String from;
  final String to;
  final DateTime date;
  String withWhom;

  Journey({
    @required this.jid,
    @required this.uid,
    @required this.from,
    @required this.to,
    @required this.date,
    this.withWhom 
  });
}

