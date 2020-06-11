import 'package:flutter/material.dart';
import './companion_list.dart';

class CompanionListScreen extends StatelessWidget {
  static const routeName = '/companion-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Ur Matched Companions',
      )),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(),
          Card(
            margin: EdgeInsets.all(10),
            elevation: 6,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              // side: BorderSide(
              //   color: Colors.grey,
              //   width: 1.0,
              // ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Container(
                child:
                    // padding: EdgeInsets.all(15),
                    //   child: Stack(
                    // children: <Widget>[
                    Column(
                  children: <Widget>[
                    Text(
                      'YOU HAVE',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '233',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.only(
              top: 5,
              bottom: 15,
            ),
            itemBuilder: (ctx, index) {
              return CompanionList();
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 10,
          ),
        ],
      ),
    );
  }
}
