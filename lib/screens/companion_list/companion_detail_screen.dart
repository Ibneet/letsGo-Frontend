import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../screens/chat/chat_screen.dart';

class CompanionDetailScreen extends StatelessWidget {
  static const routeName = '/companion-detail';
  @override
  Widget build(BuildContext context) {
    var appHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: appHeight * 0.5,
              ),
              Expanded(
                // height: appHeight * 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        20,
                      ),
                      topRight: Radius.circular(
                        20,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      10.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "User Number 1",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'GentiumBookBasic',
                            letterSpacing: 2.0,
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          height: 5,
                        ),
                        Center(
                          child: Text(
                            '20-05-2020',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "journeySource",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    height: 5,
                                  ),
                                  Text(
                                    "journeyDestination",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.import_export,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: appHeight * 0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  0.0,
                                  10.0,
                                  10,
                                  0.0,
                                ),
                                child: Material(
                                  borderRadius: BorderRadius.circular(20.0),
                                  elevation: 10.0,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.chat,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    10.0,
                                    10.0,
                                    0,
                                    0.0,
                                  ),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Material(
                                      borderRadius: BorderRadius.circular(20.0),
                                      elevation: 10.0,
                                      color: Colors.white,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          'ACCEPT',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            letterSpacing: 2.0,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Card(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 12,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: appHeight * 0.5,
                  // color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 40.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    ), // shadow direction: bottom right
                                  ],
                                ),
                                child: new Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(ChatScreen.routeName);
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    ), // shadow direction: bottom right
                                  ],
                                ),
                                child: new Icon(
                                  Icons.chat,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
