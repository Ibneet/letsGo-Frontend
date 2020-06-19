import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Auth with ChangeNotifier{
  String _token;
  String _userId;

  String get token{
    if(_token != null){
      return _token;
    }
    return null;
  }

  Future<void> signup(String name, String email, String password) async {
    const url = 'http://localhost:5000/api/users/signup';
    try{
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            "name": name, 
            "email": email, 
            "password": password
          }
        )
      );
      final responseData = json.decode(response.body);
      if(responseData['message'] != null){
        throw HttpException(responseData['message']);
      }
      _token = responseData['token'];
      _userId = responseData['createdUser']['_id'];
      notifyListeners();
    }catch(err){
      throw err;
    }
  }

  bool get isAuth{
    return token != null;
  }

  Future<void> login( String email, String password) async {
    const url = 'http://localhost:5000/api/users/login';
    try{
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            "email": email, 
            "password": password
          }
        )
      );
      final responseData = json.decode(response.body);
      if(responseData['message'] != null){
        throw HttpException(responseData['message']);
      }
      _token = responseData['token'];
      _userId = responseData['existingUser']['_id'];
      notifyListeners();
    }catch(err){
      throw err;
    }
  }
}