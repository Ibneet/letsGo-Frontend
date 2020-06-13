import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormContainer extends StatefulWidget {
  final userName;
  final userGender;
  final userDob;
  final userEmail;
  final userPhoneNumber;
  final userOccupation;

  FormContainer(
    this.userName,
    this.userGender,
    this.userDob,
    this.userEmail,
    this.userPhoneNumber,
    this.userOccupation
  );

  @override
  _FormContainerState createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  String _name;
  String _gender;
  DateTime _dob;
  String _email;
  String _phoneNumber;
  String _occupation;

  TextEditingController _dobController = new TextEditingController();
  final _form = GlobalKey<FormState>();

  void initState() {
    setState(() {
      _name = widget.userName;
      _gender = widget.userGender;
      _dob = widget.userDob;
      _email = widget.userEmail;
      _phoneNumber = widget.userPhoneNumber;
      _occupation = widget.userOccupation;
      _dobController.text = DateFormat.yMMMMd().format(_dob);
    });

    super.initState();
  }

  @override
  void dispose(){
    _dobController.dispose();
    super.dispose();
  }

  void _presentDatePicker(BuildContext context) async{
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: _dob,
      firstDate: DateTime.parse('1900-01-01'),
      lastDate: DateTime.now()
    );
    if(pickedDate != null && pickedDate != _dob) {
      setState((){
        _dob = pickedDate;
        _dobController.value = TextEditingValue(
          text: DateFormat.yMMMMd().format(pickedDate)
        );
      });
    }
  }

  void _saveChanges(){
    final bool isValid = _form.currentState.validate();
    if(!isValid){
      return null;
    }
    _form.currentState.save();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
                )
              ),
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
                            initialValue: _name,
                            decoration: InputDecoration(labelText: 'Name'),
                            textInputAction: TextInputAction.done,
                            validator: (value){
                              if(value.isEmpty){
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            onSaved: (value){
                              _name = value;
                            },
                          ),
                          SizedBox(height:20),
                          TextFormField(
                            initialValue: _email,
                            decoration: InputDecoration(labelText: 'Email'),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value){
                              if(value.isEmpty){
                               return 'Please enter an email';
                              }
                              return null;
                            },
                            onSaved: (value){
                              _email = value;
                            },
                          ),
                          SizedBox(height:20),
                          TextFormField(
                            initialValue: _phoneNumber,
                            decoration: InputDecoration(labelText: 'Phone number'),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            validator: (value){
                              if(value.isEmpty){
                               return 'Please enter a phone number';
                              }
                              return null;
                            },
                            onSaved: (value){
                              _phoneNumber = value;
                            },
                          ),
                          SizedBox(height:20),
                          GestureDetector(
                            onTap: () => _presentDatePicker(context),
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: _dobController,
                                // initialValue: DateFormat.yMMMMd().format(_dob),
                                decoration: InputDecoration(labelText: 'D.O.B.'),
                                onSaved: (value){
                                  _dob = DateFormat.yMMMMd().parse(value);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height:20),
                          TextFormField(
                            initialValue: _occupation,
                            decoration: InputDecoration(labelText: 'Occupation'),
                            textInputAction: TextInputAction.done,
                            validator: (value){
                              if(value.isEmpty){
                               return 'Please enter an occupation';
                              }
                              return null;
                            },
                            onSaved: (value){
                              _occupation = value;
                            },
                          ),
                          SizedBox(height:20),
                          TextFormField(
                            initialValue: _gender,
                            decoration: InputDecoration(labelText: 'Gender'),
                            textInputAction: TextInputAction.done,
                            onSaved: (value){
                              _gender = value;
                            },
                          ),
                          SizedBox(height:25),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: RaisedButton(
                              onPressed: _saveChanges,
                              disabledElevation: 10,
                              focusElevation: 5,
                              color: Theme.of(context).accentColor,
                              textColor: Theme.of(context).primaryColorDark,
                              padding: EdgeInsets.symmetric(horizontal:20, vertical:5),
                              child: Text(
                                'Done!',
                                style: TextStyle(
                                  fontSize: 25
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ),
            ),
          ],
        ),
      )
    );
  }
}