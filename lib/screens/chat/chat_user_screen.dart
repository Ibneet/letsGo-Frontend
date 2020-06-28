import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import './chat_users_list.dart';

class ChatUserScreen extends StatefulWidget {
  @override
  _ChatUserScreenState createState() => _ChatUserScreenState();
}

class _ChatUserScreenState extends State<ChatUserScreen> {

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Auth>(context).getChatUsers().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((err) {
        final errMess = err.toString();
        _showErrorDialog(errMess);
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var chatUsers = Provider.of<Auth>(context);
    var chatUsersData = chatUsers.chatUsers;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chats',
        )
      ),
      body: _isLoading 
      ? Center(child: CircularProgressIndicator())
      : ListView.builder(
          itemCount: chatUsersData.length,
          itemBuilder: (ctx, index) {
            return ChatUsersList(
              toId: chatUsersData[index].uid,
              name: chatUsersData[index].name,
              image: chatUsersData[index].imageUrl,
            );
          }
        )
    );
  }
}