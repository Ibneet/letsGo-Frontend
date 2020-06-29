import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/journeys.dart';
import '../history_journeys/history_card.dart';

// import './history_grid.dart';

class HistoryJourneysScreen extends StatefulWidget {
  @override
  _HistoryJourneysScreenState createState() => _HistoryJourneysScreenState();
}

class _HistoryJourneysScreenState extends State<HistoryJourneysScreen> {
  final PageController _controller = PageController(
    viewportFraction: 0.8,
  );
  int _currentPage = 0;
  // void initState() {
  //   _controller.addListener(() {
  //     int next = _controller.page.round();
  //     if (_currentPage != next) {
  //       setState(() {
  //         _currentPage = next;
  //       });
  //     }
  //   });
  //   super.initState();
  // }

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if(_isInit){
      setState(() {
        _isLoading = true;
      });
      _controller.addListener(() {
        int next = _controller.page.round();
        if (_currentPage != next) {
          setState(() {
            _currentPage = next;
          });
        }
      });
      Provider.of<Journeys>(context).getHistoryJourneys().then((_){
        setState(() {
          _isLoading = false;
        });
      }).catchError((err){
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

  void _showErrorDialog(String message){
    showDialog(
      context: context,
      builder:(ctx) => AlertDialog(
        // title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: (){
              Navigator.of(ctx).pop();
            }, 
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final _journeysData = Provider.of<Journeys>(context);
    // final _journeys = _journeysData.items;
    final _journeys = _journeysData.historyJourneys;

    return Scaffold(
        appBar: AppBar(
          title: Text('History Journeys'),
        ),
        body: _isLoading 
        ? Center(child:CircularProgressIndicator())
        : (_journeys.length == 0)
            ? Center(
                child: Text('No journey completed yet!'),
              )
            : PageView.builder(
                itemBuilder: (context, index) {
                  bool active = index == _currentPage;
                  
                  return HistoryCard(
                      _journeys[index].jid,
                      _journeys[index].from,
                      _journeys[index].to,
                      _journeys[index].date,
                      active);
                },
                scrollDirection: Axis.horizontal,
                itemCount: _journeys.length,
                controller: _controller,
              ));
  }
}
