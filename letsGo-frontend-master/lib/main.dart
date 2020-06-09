import 'package:flutter/material.dart';

import './screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'letsGo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.yellow,
        fontFamily: 'GentiumBookBasic',
        textTheme: ThemeData.light().textTheme.copyWith(
          button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'Lobster',
              fontSize: 28
            )
          ),
        )
      ),
      home: TabsScreen()
    );
  }
}

