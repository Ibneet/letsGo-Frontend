import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../providers/auth.dart';
import '../../screens/tabs_screen.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String _gender;
  DateTime _dob;
  String _phoneNumber;
  String _occupation;

  TextEditingController _dobController = new TextEditingController();
  final _form = GlobalKey<FormState>();
  var _isLoading = false;

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occurred!'),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  @override
  void initState() {
    setState(() {
      _dob = DateTime.now();
      _dobController.text = DateFormat.yMMMMd().format(_dob);
    });
    super.initState();
  }

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  void _presentDatePicker(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: _dob,
        firstDate: DateTime.parse('1900-01-01'),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != _dob) {
      setState(() {
        _dob = pickedDate;
        _dobController.value =
            TextEditingValue(text: DateFormat.yMMMMd().format(pickedDate));
      });
    }
  }

  Future<void> _saveChanges() async {
    final bool isValid = _form.currentState.validate();
    if (!isValid) {
      return null;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      // Log user in
      await Provider.of<Auth>(context, listen: false).addDetails(
        _phoneNumber,
        _gender,
        _dob,
        _occupation,
      );
    } catch (err) {
      const errMess =
          'Could not perform the specific action, please try again later.';
      _showErrorDialog(errMess);
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Padding(
                padding: EdgeInsets.only(
                  top: 50,
                  left: 20,
                  right: 20,
                ),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Form(
                    key: _form,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            initialValue: _phoneNumber,
                            decoration:
                                InputDecoration(labelText: 'Phone number'),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a phone number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _phoneNumber = value;
                            },
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => _presentDatePicker(context),
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: _dobController,
                                // initialValue: DateFormat.yMMMMd().format(_dob),
                                decoration:
                                    InputDecoration(labelText: 'D.O.B.'),
                                onSaved: (value) {
                                  _dob = DateFormat.yMMMMd().parse(value);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            initialValue: _occupation,
                            decoration:
                                InputDecoration(labelText: 'Occupation'),
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an occupation';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _occupation = value;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            initialValue: _gender,
                            decoration: InputDecoration(labelText: 'Gender'),
                            textInputAction: TextInputAction.done,
                            onSaved: (value) {
                              _gender = value;
                            },
                          ),
                          SizedBox(height: 25),
                          if (_isLoading)
                            CircularProgressIndicator()
                          else
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              child: RaisedButton(
                                onPressed: _saveChanges,
                                disabledElevation: 10,
                                focusElevation: 5,
                                color: Theme.of(context).accentColor,
                                textColor: Theme.of(context).primaryColorDark,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: Text(
                                  'Done!',
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ],
      )),
    );
  }
}
