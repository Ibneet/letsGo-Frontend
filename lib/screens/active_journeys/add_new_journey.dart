import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../providers/journeys.dart';
import './DataSearch.dart';

class AddNewJourney extends StatefulWidget {
  @override
  _AddNewJourneyState createState() => _AddNewJourneyState();
}

class _AddNewJourneyState extends State<AddNewJourney> {
  String _source;
  String _destination;
  DateTime _selectedDate;

  void initState() {
    setState(() {
      _source = 'Source';
      _destination = 'Destination';
    });

    super.initState();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 50)))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Function _addJourney =
        Provider.of<Journeys>(context, listen: false).addJourney;

    var mediaQuery = MediaQuery.of(context);
    var appHeight = mediaQuery.size.height - mediaQuery.padding.top;
    var appWidth = mediaQuery.size.width;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: appHeight * 0.01,
      ),
      height: appHeight * .25,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              showSearch(
                context: context,
                delegate: DataSearch(_source),
              ).then((result) {
                if (result.isNotEmpty) {
                  setState(() {
                    _source = result;
                    print(_source);
                  });
                } else {
                  setState(() {
                    _source = 'Source';
                    print(_source);
                  });
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              height: appHeight * 0.075,
              child: Card(
                elevation: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      Icons.my_location,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: mediaQuery.size.width * 0.75,
                      child: Text(
                        '$_source',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showSearch(
                context: context,
                delegate: DataSearch(_destination),
              ).then((result) {
                if (result.isNotEmpty) {
                  setState(() {
                    _destination = result;
                  });
                } else {
                  setState(() {
                    _destination = 'Destination';
                  });
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              height: appHeight * 0.075,
              child: Card(
                elevation: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      Icons.pin_drop,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: mediaQuery.size.width * 0.75,
                      child: Text(
                        '$_destination',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.search,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(4),
                height: appHeight * 0.075,
                width: appWidth * 0.5,
                child: InkWell(
                  onTap: _presentDatePicker,
                  child: Card(
                    elevation: 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                        ),
                        Container(
                          alignment: Alignment.center,
                          // width: mediaQuery.size.width * 0.4,
                          child: Text(
                            _selectedDate == null
                                ? 'Choose A Date'
                                : DateFormat.yMMMd().format(_selectedDate),
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                height: appHeight * 0.075,
                width: appWidth * 0.5,
                child: InkWell(
                  splashColor: Colors.black,
                  child: Card(
                    elevation: 6,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Add Journey',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  onTap: () => _addJourney(
                    'u1',
                    _source,
                    _destination,
                    _selectedDate,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
