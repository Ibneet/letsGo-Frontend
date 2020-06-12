import 'package:flutter/material.dart';

import '../user_profile_edit/user_profile_edit_screen.dart';
import './journeys_count.dart';
import './user_data.dart';
import '../../models/user.dart';

class DraggableSheet extends StatelessWidget {
  final User currentUser;
  final int countCurrent;
  final int countHistory;


  DraggableSheet(
    this.currentUser,
    this.countCurrent,
    this.countHistory,
  );

  void _editDetails(BuildContext ctx){
    Navigator.of(ctx).pushNamed(
      UserProfileEditScreen.routeName,
      arguments: {
        'name': currentUser.name,
        'imageUrl': currentUser.imageUrl,
        'gender': currentUser.gender,
        'dob': currentUser.dob,
        'email': currentUser.email,
        'phoneNumber': currentUser.phoneNumber,
        'occupation': currentUser.occupation
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      maxChildSize: 0.8,
      minChildSize: 0.2,
      builder: (context, controller) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40)),
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.5), Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
            )
          ),
          child: SingleChildScrollView(
            controller: controller,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.025,
                    child: Icon(
                      Icons.arrow_drop_up,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: UserData(currentUser),
                  ),
                  JourneyCount(
                    countCurrent, 
                    countHistory
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {},
                        ),
                        Spacer(),
                        IconButton(
                          onPressed:(){
                            _editDetails(context);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Spacer(),
                      ]
                    ),
                  ),
                  InkWell(
                    onTap: (){},
                    splashColor: Colors.red,
                    radius: 2,
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height*0.075,
                      child: ShaderMask(
                        shaderCallback: (bounds) => 
                        RadialGradient(
                          center: Alignment.topLeft,
                          radius: 1.0,
                          colors: [
                            Colors.red[300],
                            Colors.deepOrange
                          ],
                          tileMode: TileMode.mirror
                        ).createShader(bounds),
                        child: const Text(
                          'Sign Out',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'GentiumBookBasic'
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        );
      },
    );
  }
}

