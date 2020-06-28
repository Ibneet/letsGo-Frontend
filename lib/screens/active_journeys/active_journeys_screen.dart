import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './journey_item.dart';
import './add_new_journey.dart';
import '../../providers/journeys.dart';


class ActiveJourneysScreen extends StatefulWidget {
  @override
  _ActiveJourneysScreenState createState() => _ActiveJourneysScreenState();
}

class _ActiveJourneysScreenState extends State<ActiveJourneysScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if(_isInit){
      setState(() {
        _isLoading = true;
      });
      Provider.of<Journeys>(context).getActiveJourneys().then((_){
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
    var journeys = Provider.of<Journeys>(context);
    var journeysData = journeys.items;
    var appHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Want A Companion'),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: appHeight * .25,
            color: Theme.of(context).primaryColor,
            // decoration: BoxDecoration(),
            child: AddNewJourney(),
          ),
          Expanded(
            child: _isLoading 
            ? Center(child: CircularProgressIndicator(),)
            : ListView(
              itemExtent: appHeight* .2,
              // diameterRatio: 5,
              children: journeysData.map(
                (journey) {
                  return JourneyItem(
                    journeyId: journey.jid,
                    journeyDate: journey.date,
                    journeyDestination: journey.to,
                    journeySource: journey.from,
                    journeyWith: journey.withWhom,
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
      // body: CustomScrollView(
      //   slivers: <Widget>[
      //     SliverAppBar(
      //       title: Container(
      //         width: double.infinity,
      //         height: appHeight * 0.05,
      //         child: const Text('Want A Companion'),
      //       ),
      //       pinned: true,
      //       expandedHeight: appHeight * .3,
      //       flexibleSpace: FlexibleSpaceBar(
      //         background: AddNewJourney(),
      //       ),
      //     ),
      //     SliverGrid(
      //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 2,
      //         childAspectRatio: 3 / 2,
      //         crossAxisSpacing: 15,
      //         mainAxisSpacing: 15,
      //       ),
      //       delegate: SliverChildBuilderDelegate(
      //         (ctx, index) => JourneyItem(
      //           journeyDate: journeysData[index].date,
      //           journeyDestination: journeysData[index].to,
      //           journeySource: journeysData[index].from,
      //           journeyWith: journeysData[index].withWhom,
      //         ),
      //         childCount: journeysData.length,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
