import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../screens/chat/chat_screen.dart';
import '../../screens/companion_list/companion_detail_screen.dart';
import '../../socket_utils.dart';

class CompanionList extends StatefulWidget {
  final String toId;
  final String name;
  final DateTime dob;
  final String occupation;
  final String gender;
  final String from;
  final String to;
  final DateTime date;

  CompanionList(
      {this.toId,
      this.name,
      this.dob,
      this.occupation,
      this.gender,
      this.from,
      this.to,
      this.date});

  @override
  _CompanionListState createState() => _CompanionListState();
}

class _CompanionListState extends State<CompanionList> {
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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 6,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(CompanionDetailScreen.routeName,
              arguments: {
                'name': widget.name,
                'from': widget.from,
                'to': widget.to,
                'date': widget.date
              });
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '${widget.name}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(DateFormat.yMMMd().format(widget.dob)),
                          Text('${widget.occupation}'),
                          Text('${widget.gender}')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Material(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ChatScreen.routeName, arguments: {
                        'toId': widget.toId,
                        'name': widget.name,
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'REQUEST',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
