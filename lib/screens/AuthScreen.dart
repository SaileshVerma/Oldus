import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:oldies/models/exception.dart';
import 'package:oldies/providerr/auth.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  static const routname = "/authscreen";
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  AuthMode _authMode = AuthMode.Login;

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  void showErrDialaog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("An error occur"),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text("Okay"),
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
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .signIn(_authData['email'], _authData['password']);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signUp(_authData['email'], _authData['password']);
      }

      Navigator.of(context).pushReplacementNamed('/mainscreen');
    } on HttpException catch (error) {
      var errmsg = "Authentication failed";
      if (error.toString().contains('EMAIL_EXISTS')) {
        errmsg = 'email is already in use';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errmsg = 'GIVEN MAIL IS INVALID PLS CHECK';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errmsg = 'PASSWORD IS TOO WEAK';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errmsg = 'COULD NOT FIND THE EMAIL';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errmsg = 'pls enter a valid psswrd';
      }
      showErrDialaog(errmsg);
    } catch (error) {
      const errmsg = "Could not auth you !! ";
      showErrDialaog(errmsg);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.amber[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "#Welcome User",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 8.0,
                    child: Container(
                      height: _authMode == AuthMode.Signup ? 320 : 260,
                      constraints: BoxConstraints(
                          minHeight: _authMode == AuthMode.Signup ? 320 : 260),
                      width: deviceSize.width * 0.75,
                      padding: EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "User's Mail ",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: Colors.amber),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty || !value.contains('@')) {
                                    return 'Invalid email!';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _authData['email'] = value;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: Colors.amber),
                                  ),
                                ),
                                obscureText: true,
                                controller: _passwordController,
                                validator: (value) {
                                  if (value.isEmpty || value.length < 5) {
                                    return 'Password is too short!';
                                  }
                                },
                                onSaved: (value) {
                                  _authData['password'] = value;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              if (_authMode == AuthMode.Signup)
                                TextFormField(
                                  enabled: _authMode == AuthMode.Signup,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.amber),
                                    ),
                                  ),
                                  obscureText: true,
                                  validator: _authMode == AuthMode.Signup
                                      ? (value) {
                                          if (value !=
                                              _passwordController.text) {
                                            return 'Passwords do not match!';
                                          }
                                        }
                                      : null,
                                ),
                              SizedBox(
                                height: 20,
                              ),
                              if (_isLoading)
                                CircularProgressIndicator()
                              else
                                RaisedButton(
                                  child: Text(_authMode == AuthMode.Login
                                      ? 'LOGIN'
                                      : 'SIGN UP'),
                                  onPressed: _submit,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 8.0),
                                  color: Colors.amber,
                                  textColor: Colors.black,
                                ),
                              FlatButton(
                                child: Text(
                                    '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                                onPressed: _switchAuthMode,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 4),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                textColor: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                FlatButton.icon(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed("/organiserauthscreen");
                  },
                  icon: Icon(Icons.people),
                  label: Text(
                    "SIGN UP AS ORGANISER-->",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
