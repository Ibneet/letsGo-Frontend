import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormContainer extends StatelessWidget {
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            initialValue: userName,
                            decoration: InputDecoration(labelText: 'Name'),
                            textInputAction: TextInputAction.done,
                          ),
                          TextFormField(
                            initialValue: userEmail,
                            decoration: InputDecoration(labelText: 'Email'),
                            textInputAction: TextInputAction.done,
                          ),
                          TextFormField(
                            initialValue: userPhoneNumber,
                            decoration: InputDecoration(labelText: 'Phone number'),
                            textInputAction: TextInputAction.done,
                          ),
                          TextFormField(
                            initialValue: DateFormat.yMMMMd().format(userDob),
                            decoration: InputDecoration(labelText: 'D.O.B.'),
                            textInputAction: TextInputAction.done,
                          ),
                          TextFormField(
                            initialValue: userGender,
                            decoration: InputDecoration(labelText: 'Gender'),
                            textInputAction: TextInputAction.done,
                          ),
                          TextFormField(
                            initialValue: userOccupation,
                            decoration: InputDecoration(labelText: 'Occupation'),
                            textInputAction: TextInputAction.done,
                          ),
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