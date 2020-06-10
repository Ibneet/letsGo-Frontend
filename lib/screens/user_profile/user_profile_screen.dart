import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../dummy_data.dart';

class UserProfileScreen extends StatelessWidget {
  final currentUser = dummyUsers.singleWhere(
    (user) {
      return user.uid == 'u1';
    }
  );

  Widget listTile(icon, title, sub){
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal:20),
      leading: CircleAvatar(
        child:icon,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'GentiumBookBasic',
          color: Colors.grey
        )
      ),
      subtitle: Text(
        '$sub',
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'GentiumBookBasic',
          color: Colors.black
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Material(
              elevation: 20.0,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)
                ),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: appHeight*0.4 ,
                      child: Image.network(
                        currentUser.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 3,
                      bottom: 1,
                      child: FloatingActionButton(
                        onPressed: (){
                          
                        },
                        child: Icon(Icons.edit),
                      ),
                    )
                  ], 
                ),
              ),
            ),
            listTile(
              Icon(Icons.perm_identity), 
              'Name', 
              currentUser.name
            ),
            listTile(
              Icon(Icons.phone), 
              'Phone Number', 
              currentUser.phoneNumber
            ),
            listTile(
              Icon(Icons.email), 
              'Email', 
              currentUser.email
            ),
            listTile(
              Icon(Icons.cake), 
              'D.O.B.', 
              DateFormat.yMMMMd().format(currentUser.dob)
            ),
            listTile(
              Icon(Icons.work), 
              'Occupation', 
              currentUser.occupation
            ),
            listTile(
              Icon(Icons.accessibility), 
              'Gender', 
              currentUser.gender
            ),
          ],
        ),
      ),
    );
  }
}
