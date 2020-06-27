import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../models/chat_message.dart';
import './chat_title.dart';
import '../../socket_utils.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';

  @override
  _ChatUserScreenState createState() => _ChatUserScreenState();
}

class _ChatUserScreenState extends State<ChatScreen> {
  List<ChatMessage> _chatMessages = [];
  String _toChatUserId;
  String _toChatUserName;
  UserOnlineStatus _userOnlineStatus;
  String _uid;

  TextEditingController _chatTextController;
  ScrollController _chatListController;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState((fn));
    }
  }

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      final String toId = routeArgs['toId'];
      final name = routeArgs['name'];
      Provider.of<Auth>(context).addUserChat(toId).then((_) {
        print('userchat added');
      }).catchError((err) {
        final errMess = err.toString();
        print(errMess);
      });
      _uid = Provider.of<Auth>(context).uid;
      String idChat = _uid.compareTo(toId) == -1 ? _uid + toId : toId + _uid;
      Provider.of<Auth>(context)
          .getHistoryChats(idChat)
          .then((_) => print('History chats added'))
          .catchError((err) {
        final errMess = err.toString();
        print(errMess);
      });

      // Provider.of<Auth>(context).chats;
      // print(_chatMessages.length);
      _toChatUserId = toId;
      _toChatUserName = name;
      _chatTextController = TextEditingController();
      _chatListController = ScrollController(initialScrollOffset: 0);
      _userOnlineStatus = UserOnlineStatus.connecting;
      _initSocketListener();
      _checkOnline();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _removeListeners();
    super.dispose();
  }

  _checkOnline() {
    ChatMessage chatMessage = ChatMessage(
        chatId: null,
        from: _uid,
        to: _toChatUserId,
        toUserOnlineStatus: false,
        message: '',
        chatType: SocketUtils.SINGLE_CHAT);
    SocketUtils.checkOnline(chatMessage);
  }

  _initSocketListener() async {
    SocketUtils.setOnChatMessageReceiveListener(onChatMessageReceived);
    SocketUtils.setOnlineUserStatusListener(onUserStatus);
  }

  _removeListeners() async {
    SocketUtils.setOnChatMessageReceiveListener(null);
    SocketUtils.setOnlineUserStatusListener(null);
  }

  onUserStatus(data) {
    print('onUserStatus $data');
    ChatMessage chatMessage = ChatMessage.fromJson(data);
    setState(() {
      _userOnlineStatus = chatMessage.toUserOnlineStatus
          ? UserOnlineStatus.online
          : UserOnlineStatus.offline;
    });
  }

  onChatMessageReceived(data) {
    print('onChatMessageReceived $data');
    ChatMessage chatMessage = ChatMessage.fromJson(data);
    chatMessage.isFromMe = false;
    processMessage(chatMessage);
    _chatListScrollToBottom();
  }

  processMessage(chatMessage) {
    setState(() {
      _chatMessages.add(chatMessage);
    });
  }

  _chatListScrollToBottom() {
    Timer(Duration(milliseconds: 100), () {
      if (_chatListController.hasClients) {
        _chatListController.animateTo(
            _chatListController.position.maxScrollExtent,
            duration: Duration(milliseconds: 100),
            curve: Curves.decelerate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var chats = Provider.of<Auth>(context);
    _chatMessages = _chatMessages.isEmpty ? chats.chats : _chatMessages;
    return Scaffold(
      appBar: AppBar(
        title: ChatTitle(
          name: _toChatUserName,
          userOnlineStatus: _userOnlineStatus,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  controller: _chatListController,
                  itemCount: _chatMessages == null || _chatMessages.length == 0
                      ? 0
                      : _chatMessages.length,
                  itemBuilder: (context, index) {
                    ChatMessage chatMessage = _chatMessages[index];
                    bool fromMe = chatMessage.from == _uid;
                    print('chatMessage.message: ${chatMessage.message}');
                    return Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(10),
                        alignment: fromMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        color: fromMe ? Colors.green : Colors.grey,
                        child: Text(chatMessage.message));
                  }),
            ),
            _bottomChatArea()
          ],
        ),
      ),
    );
  }

  _bottomChatArea() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          _chatTextArea(),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _sendMessageBtnTap();
            },
          )
        ],
      ),
    );
  }

  _sendMessageBtnTap() async {
    print('$_toChatUserName');
    if (_chatTextController.text.isEmpty) {
      return;
    }
    ChatMessage chatMessage = ChatMessage(
        chatId: null,
        from: _uid,
        to: _toChatUserId,
        toUserOnlineStatus: false,
        message: _chatTextController.text,
        chatType: SocketUtils.SINGLE_CHAT,
        isFromMe: true);
    SocketUtils.sendSingleChatMessage(chatMessage);
    processMessage(chatMessage);
    _chatListScrollToBottom();
  }

  _chatTextArea() {
    return Expanded(
      child: TextField(
        controller: _chatTextController,
        decoration: InputDecoration(
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(10),
            hintText: 'Type message'),
      ),
    );
  }
}
