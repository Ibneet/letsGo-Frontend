import 'package:flutter/material.dart';
import './text_field_container.dart';
// import 'package:flutter_auth/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final String hint;
  final Function onSaved;
  final Function validator;
  final TextEditingController controller;
  const RoundedPasswordField({
    Key key,
    this.hint,
    this.validator,
    this.onSaved,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: true,
        onSaved: onSaved,
        controller: controller,
        validator: validator,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          hintText: hint == null ? "Password" : hint,
          icon: Icon(
            Icons.lock,
            color: Theme.of(context).primaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: Theme.of(context).primaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
