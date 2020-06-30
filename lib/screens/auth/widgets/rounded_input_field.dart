import 'package:flutter/material.dart';
import './text_field_container.dart';
// import 'package:flutter_auth/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function validator;
  final TextInputType type;
  final Function onSaved;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.type,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        enabled: true,
        validator: validator,
        onSaved: onSaved,
        keyboardType: type,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
