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
            color: Colors.pink[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      'MATCHED COMPANIONS',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '23',
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
              return Padding(
                padding: index.isEven
                    ? EdgeInsets.fromLTRB(10, 5, 5, 5)
                    : EdgeInsets.fromLTRB(0, 5, 10, 5),
                child: CompanionList(),
              );
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
