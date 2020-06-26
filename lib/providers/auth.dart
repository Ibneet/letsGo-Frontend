import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  final port = Platform.isIOS ? 'localhost' : '10.0.2.2';
  String _token;
  String _userId;

  bool get isAuth {
    return token != null;
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
}
