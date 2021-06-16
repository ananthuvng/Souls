import 'package:agora_flutter_quickstart/src/pages/loading.dart';
import 'package:agora_flutter_quickstart/src/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:agora_flutter_quickstart/src/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:agora_flutter_quickstart/src/authenticate/user.dart';
import '../../home.dart';

class Signemail extends StatefulWidget {
  @override
  _SignemailState createState() => _SignemailState();
}

class _SignemailState extends State<Signemail> {
  bool loading = false;
  String email;
  String error = '';
  String password;
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return loading
        ? Loading()
        : Scaffold(
            body: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 400,
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Email',
                              fillColor: Color.fromRGBO(39, 106, 116, 1),
                              filled: true,
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color.fromRGBO(254, 137, 58, 1),
                                width: 2,
                              ))),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'password',
                              fillColor: Color.fromRGBO(39, 106, 116, 1),
                              filled: true,
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color.fromRGBO(254, 137, 58, 1),
                                width: 2,
                              ))),
                          validator: (val) => val.length < 8
                              ? 'Enter password 8+ charcter'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_formkey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result =
                                  await _auth.signinwithemail(email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'plzz enter valid mail';
                                });
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                );
                              }
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(254, 137, 58, 1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                                child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                        ),
                        SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Dont have an Account? ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Register here',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          error,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: Color.fromRGBO(48, 57, 66, 1),
          );
  }
}
