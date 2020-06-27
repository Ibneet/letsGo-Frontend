import 'package:flutter/material.dart';

enum UserOnlineStatus { connecting, online, offline }

class ChatTitle extends StatelessWidget {
  final String name;
  final UserOnlineStatus userOnlineStatus;

  const ChatTitle({
    Key key, 
    @required this.name, 
    @required this.userOnlineStatus
  });

  _getOnlineStatus() {
    if(userOnlineStatus == UserOnlineStatus.online) {
      return 'online';
    }
    if(userOnlineStatus == UserOnlineStatus.offline) {
      return 'offline';
    }
    return 'connecting...';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(name),
          Text(
            _getOnlineStatus(),
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14
            )
          )
        ],
      ),
    );
  }
}
