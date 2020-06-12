import 'package:flutter/material.dart';

import 'package:intl/intl.dart';



class UserData extends StatelessWidget {
  final currentUser;

  UserData(this.currentUser);

  Widget listTile(icon, title, sub) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      leading: CircleAvatar(
        child: icon,
        backgroundColor: Colors.pink[100],
      ),
      title: Text(title,
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'GentiumBookBasic',
              color: Colors.white)),
      subtitle: Text('$sub',
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'GentiumBookBasic',
              color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        listTile(
            Icon(
              Icons.perm_identity,
            ),
            'Name',
            currentUser.name),
        Divider(
          color: Colors.white,
        ),
        listTile(Icon(Icons.phone), 'Phone Number',
            currentUser.phoneNumber),
        Divider(
          color: Colors.white,
        ),
        listTile(Icon(Icons.email), 'Email',
            currentUser.email),
        Divider(
          color: Colors.white,
        ),
        listTile(Icon(Icons.cake), 'D.O.B.',
            DateFormat.yMMMMd().format(currentUser.dob)),
        Divider(
          color: Colors.white,
        ),
        listTile(Icon(Icons.work), 'Occupation',
            currentUser.occupation),
        Divider(
          color: Colors.white,
        ),
        listTile(Icon(Icons.accessibility), 'Gender',
            currentUser.gender),
        Divider(
          color: Colors.white,
        ),
      ]
    );
  }
}

