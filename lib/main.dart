import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/tabs_screen.dart';
import './providers/journeys.dart';
import './screens/companion_list/companion_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Journeys(),
      child: MaterialApp(
        title: 'letsGo',
        theme: ThemeData(
            primarySwatch: Colors.cyan,
            accentColor: Colors.orangeAccent[100],
            fontFamily: 'GentiumBookBasic',
            textTheme: ThemeData.light().textTheme.copyWith(
              button: TextStyle(color: Colors.white),
              headline1: TextStyle(
                fontSize: 18,
                fontFamily: 'GentiumBookBasic',
                color: Colors.white
              ),
            ),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(fontFamily: 'Lobster', fontSize: 28),
              ),
            )),
        home: TabsScreen(),
        routes: {
          CompanionListScreen.routeName: (ctx) => CompanionListScreen(),
        },
      ),
    );
  }
}
