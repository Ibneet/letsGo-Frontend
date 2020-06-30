import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:frontend/models/chat_message.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';
import '../models/user.dart';

class Auth with ChangeNotifier {
  final port = Platform.isIOS ? 'localhost' : '10.0.2.2';
  String _token;
  String _userId;

  List<User> _chatUsers = [];

  List<ChatMessage> _chats = [];

  bool isSignUp = false;

  bool get isSignUpTrue {
    return isSignUp;
  }

  bool get isAuth {
    return token != null;
  }

  List<ChatMessage> get chats {
    return [..._chats];
  }

  List<User> get chatUsers {
    return [..._chatUsers];
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  String get uid {
    if (_userId != null) {
      return _userId;
    }
    return null;
  }

  Future<void> addDetails(String phonenumber, String gender, DateTime dob,
      String occupation) async {
    var url = 'http://$port:5000/api/users/details/me';
    try {
      final response = await http.patch(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_token'
          },
          body: json.encode({
            "phone_number": phonenumber,
            "gender": gender,
            "dob": DateFormat.yMMMMd().format(dob),
            "occupation": occupation,
          }));
      final responseData = json.decode(response.body);
      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      }
      print(responseData);

      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  String _idchat;
  Future<void> addUserChat(String to) async {
    var url = 'http://$port:5000/api/chatuser';
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_token'
          },
          body: json.encode({"from": _userId, "to": to}));
      final responseData = json.decode(response.body);
      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      }
      print(responseData);
      _idchat = responseData['userchat']['chatID'];
      print(_idchat);
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> signup(String name, String email, String password) async {
    final url = 'http://$port:5000/api/users/signup';
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json
              .encode({"name": name, "email": email, "password": password}));
      final responseData = json.decode(response.body);
      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      }
      _token = responseData['token'];
      _userId = responseData['createdUser']['_id'];
      isSignUp = true;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({'token': _token, 'userId': _userId});
      prefs.setString('userData', userData);
    } catch (err) {
      throw err;
    }
  }

  Future<void> login(String email, String password) async {
    final url = 'http://$port:5000/api/users/login';
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({"email": email, "password": password}));
      final responseData = json.decode(response.body);

      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      }
      _token = responseData['token'];
      _userId = responseData['existingUser']['_id'];
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({'token': _token, 'userId': _userId});

      prefs.setString('userData', userData);
    } catch (err) {
      throw err;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    final url = 'http://$port:5000/api/users/logout';
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
        },
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      }
      _token = null;
      _userId = null;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
    } catch (err) {
      throw err;
    }
  }

  Future<void> getHistoryChats(String idchat) async {
    var url = 'http://$port:5000/api/chats/$idchat';
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $_token'},
      );

      print('IdChat: $idchat');
      final responseData = json.decode(response.body);
      print('getChats $responseData');
      if (responseData['message'] != null) {
        _chats = [];
        throw HttpException(responseData['message']);
      }
      final extractedData = responseData['chat'] as List<dynamic>;
      final List<ChatMessage> chatData = [];
      extractedData.forEach((chat) {
        chatData.add(ChatMessage(
          chatId: chat['chatID'],
          from: chat['from'],
          to: chat['to'],
          message: chat['message'],
          chatType: chat['chatType'],
          toUserOnlineStatus: chat['toUserOnlineStatus'],
        ));
      });
      _chats = chatData;
      // print(responseData['journey']);
      notifyListeners();
    } catch (err) {
      throw (err);
    }
  }

  Future<void> getChatUsers() async {
    var url = 'http://$port:5000/api/chatuser/userChats';
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $_token'},
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['message'] != null) {
        _chatUsers = [];
        throw HttpException(responseData['message']);
      }
      final extractedData = responseData['chatUsers'] as List<dynamic>;
      final List<User> chatUsersData = [];
      extractedData.forEach((chatUser) {
        chatUsersData.add(User(
            uid: chatUser['_id'],
            name: chatUser['name'],
            imageUrl: chatUser['image']));
      });
      print(chatUsersData);
      _chatUsers = chatUsersData;
      notifyListeners();
    } catch (err) {
      print('hi');
      throw (err);
    }
  }
}
