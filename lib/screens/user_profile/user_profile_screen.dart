import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/journeys.dart';
import '../../dummy_data.dart';

class UserProfileScreen extends StatelessWidget {
  final currentUser = dummyUsers.singleWhere((user) {
    return user.uid == 'u1';
  });

  Widget listTile(icon, title, sub) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      leading: CircleAvatar(
        child: icon,
        backgroundColor: Colors.pink[100],
      ),
      title: Text(title,
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'GentiumBookBasic',
              color: Colors.white)),
      subtitle: Text('$sub',
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'GentiumBookBasic',
              color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final journeysData = Provider.of<Journeys>(context);
    final int countCurrent = journeysData.countCurrJourneys;
    final int countHistory = journeysData.countHistJourneys;

    final appHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: appHeight,
            child: Image.network(
              currentUser.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.2,
            maxChildSize: 0.8,
            minChildSize: 0.2,
            builder: (context, controller) {
              return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      gradient: LinearGradient(
                          colors: [Colors.black.withOpacity(0.5), Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Icon(
                              Icons.arrow_drop_up,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Column(children: [
                              listTile(
                                  Icon(
                                    Icons.perm_identity,
                                  ),
                                  'Name',
                                  currentUser.name),
                              Divider(
                                color: Colors.white,
                              ),
                              listTile(Icon(Icons.phone), 'Phone Number',
                                  currentUser.phoneNumber),
                              Divider(
                                color: Colors.white,
                              ),
                              listTile(Icon(Icons.email), 'Email',
                                  currentUser.email),
                              Divider(
                                color: Colors.white,
                              ),
                              listTile(Icon(Icons.cake), 'D.O.B.',
                                  DateFormat.yMMMMd().format(currentUser.dob)),
                              Divider(
                                color: Colors.white,
                              ),
                              listTile(Icon(Icons.work), 'Occupation',
                                  currentUser.occupation),
                              Divider(
                                color: Colors.white,
                              ),
                              listTile(Icon(Icons.accessibility), 'Gender',
                                  currentUser.gender),
                              Divider(
                                color: Colors.white,
                              ),
                            ]),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color:
                                                Theme.of(context).accentColor,
                                            width: 2,
                                          )
                                          // gradient: LinearGradient(
                                          //     colors: [
                                          //       Colors.pink[100],
                                          //       Colors.purple[200],
                                          //       Colors.cyan,
                                          //       Colors.lightBlue[200]
                                          //     ],
                                          //     begin: Alignment.topLeft,
                                          //     end: Alignment.bottomRight),
                                          ),
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        '$countCurrent',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontFamily: 'GentiumBookBasic',
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                    Text('Current Journeys',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'GentiumBookBasic',
                                            color: Colors.white))
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Theme.of(context).accentColor,
                                          width: 2,
                                        ),
                                        // gradient: LinearGradient(
                                        //     colors: [
                                        //       Colors.pink[100],
                                        //       Colors.purple[200],
                                        //       Colors.cyan,
                                        //       Colors.lightBlue[200]
                                        //     ],
                                        //     begin: Alignment.topLeft,
                                        //     end: Alignment.bottomRight),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        '$countHistory',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontFamily: 'GentiumBookBasic',
                                            color:
                                                Theme.of(context).accentColor),
                                      ),
                                    ),
                                    Text('History Journeys',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'GentiumBookBasic',
                                            color: Colors.white))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      Icons.settings,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    onPressed: () {},
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    onPressed: () {},
                                  ),
                                  Spacer(),
                                ]),
                          )
                        ],
                      ),
                    ),
                  ));
            },
          )
        ],
      ),
    );
  }
}
