import 'package:flutter/material.dart';

class Journey with ChangeNotifier{
  final String jid;
  // final String creator;
  final String from;
  final String to;
  final DateTime date;
  String withWhom;

  Journey({
    @required this.jid,
    // @required this.creator,
    @required this.from,
    @required this.to,
    @required this.date,
    @required this.withWhom 
  });
}

