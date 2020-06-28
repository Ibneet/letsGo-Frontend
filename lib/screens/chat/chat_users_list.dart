import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../socket_utils.dart';
import '../../providers/auth.dart';
import '../../screens/chat/chat_screen.dart';

class ChatUsersList extends StatefulWidget {
  final String toId;
  final String name;
  final String image;

  ChatUsersList({this.toId, this.name, this.image});

  @override
  _ChatUsersListState createState() => _ChatUsersListState();
}

class _ChatUsersListState extends State<ChatUsersList> {

  bool _connectedToSocket;
  String _connectMessage;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _connectedToSocket = false;
      _connectMessage = 'Connecting...';
      final uid = Provider.of<Auth>(context).uid;
      _connectToSocket(uid);
      super.didChangeDependencies();
    }
    _isInit = false;
  }

  _connectToSocket(uid) async {
    print('Connecting logged in user $uid');
    await SocketUtils.initSocket(uid);
    SocketUtils.connectToSocket();
    SocketUtils.setOnConnectListener(onConnect);
    SocketUtils.setOnConnectionTimeOutListener(onConnectionTimeout);
    SocketUtils.setOnConnectionErrorListener(onConnectionError);
    SocketUtils.setOnErrorListener(onError);
    SocketUtils.setOnDisconnectListener(onDisConnect);
  }

  onConnect(data) {
    print('Connected $data');
    setState(() {
      _connectedToSocket = true;
      _connectMessage = 'Connected';
    });
  }

  onConnectionTimeout(data) {
    print('onConnectionTimeout $data');
    setState(() {
      _connectedToSocket = false;
      _connectMessage = 'Connection time out';
    });
  }

  onConnectionError(data) {
    print('onConnectionError $data');
    setState(() {
      _connectedToSocket = false;
      _connectMessage = 'Connection error';
    });
  }

  onError(data) {
    print('onError $data');
    setState(() {
      _connectedToSocket = false;
      _connectMessage = 'Connection Error';
    });
  }

  onDisConnect(data) {
    print('onDisConnect $data');
    setState(() {
      _connectedToSocket = false;
      _connectMessage = 'Disconnected';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ChatScreen.routeName, arguments: {
          'toId': widget.toId,
          'name': widget.name,
        });
      },
      leading: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              widget.image,
            ),
          ),
        ),
      ),
      title: Text(widget.name),
    );
  }
}