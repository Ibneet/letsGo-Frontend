import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/tabs_screen.dart';
import './providers/journeys.dart';
import './providers/auth.dart';
import './screens/companion_list/companion_list_screen.dart';
import './screens/user_profile_edit/user_profile_edit_screen.dart';
import './screens/auth/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Journeys>(
          update: (ctx, auth, prevJourneys) => Journeys(
            auth.token,
            prevJourneys == null ? [] : prevJourneys.items
          ), 
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'letsGo',
          theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.pink[100],
              fontFamily: 'GentiumBookBasic',
              textTheme: ThemeData.light().textTheme.copyWith(
                    button: TextStyle(color: Colors.white),
                    headline1: TextStyle(
                        fontSize: 18,
                        fontFamily: 'GentiumBookBasic',
                        color: Colors.white),
                  ),
              appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(fontFamily: 'Lobster', fontSize: 28),
                    ),
              )),
          home: auth.isAuth ? TabsScreen() : AuthScreen(),
          routes: {
            CompanionListScreen.routeName: (ctx) => CompanionListScreen(),
            UserProfileEditScreen.routeName: (ctx) => UserProfileEditScreen()
          },
        ),
      )
    );
  }
}
