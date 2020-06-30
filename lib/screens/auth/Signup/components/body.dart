import 'dart:math';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../providers/auth.dart';
import '../../../../models/http_exception.dart';

import '../../Login/login_screen.dart';
import '../../Signup/components/background.dart';
import '../../widgets/already_have_an_account_acheck.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/rounded_input_field.dart';
import '../../widgets/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
  };

  var _isLoading = false;
  final _passwordController = TextEditingController();

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
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      // Sign user up
      await Provider.of<Auth>(context, listen: false)
          .signup(_authData['name'], _authData['email'], _authData['password'])
          .then((_) {
        Navigator.of(context).pushReplacementNamed('/details');
      });
    } on HttpException catch (err) {
      final errMess = err.toString();
      _showErrorDialog(errMess);
    } catch (err) {
      const errMess =
          'Could not perform the specific action, please try again later.';
      _showErrorDialog(errMess);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.35,
              ),
              RoundedInputField(
                hintText: "Name",
                type: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide your name.';
                  }
                },
                onSaved: (value) {
                  _authData['name'] = value;
                },
              ),
              RoundedInputField(
                hintText: "Your Email",
                type: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Invalid email!';
                  }
                },
                onSaved: (value) {
                  _authData['email'] = value;
                },
              ),
              RoundedPasswordField(
                validator: (value) {
                  if (value.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                },
                onSaved: (value) {
                  _authData['password'] = value;
                },
                controller: _passwordController,
              ),
              RoundedPasswordField(
                hint: 'Confirm Password',
                validator: (value) {
                  (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match!';
                    }
                  };
                },
              ),
              if (_isLoading)
                CircularProgressIndicator()
              else
                RoundedButton(color: Theme.of(context).primaryColor,
                  text: "SIGNUP",
                  press: _submit,
                ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
