import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../providers/journeys.dart';
import './companion_list.dart';

class CompanionListScreen extends StatefulWidget {
  static const routeName = '/companion-list';

  @override
  _CompanionListScreenState createState() => _CompanionListScreenState();
}

class _CompanionListScreenState extends State<CompanionListScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _jid;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      _jid = routeArgs['jid'];
      final from = routeArgs['from'];
      final to = routeArgs['to'];
      final date = routeArgs['date'];
      Provider.of<Journeys>(context).getCompanions(from, to, date).then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((err) {
        final errMess = err.toString();
        _showErrorDialog(errMess);
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        // title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var companions = Provider.of<Journeys>(context);
    var companionsData = companions.compaions;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Ur Matched Companions',
      )),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Material(
              child: ListView(
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
                              '${companionsData.length}',
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
                        child: Hero(
                          tag: '$index',
                          child: CompanionList(
                            jid: _jid,
                            toId: companionsData[index].toId,
                            name: companionsData[index].name,
                            dob: companionsData[index].dob,
                            occupation: companionsData[index].occupation,
                            gender: companionsData[index].gender,
                            from: companionsData[index].from,
                            to: companionsData[index].to,
                            date: companionsData[index].date,
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: companionsData.length,
                  ),
                ],
              ),
            ),
    );
  }
}
