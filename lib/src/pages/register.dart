import 'package:agora_flutter_quickstart/home.dart';
import 'package:agora_flutter_quickstart/src/pages/email.dart';
import 'package:agora_flutter_quickstart/src/pages/loading.dart';
import 'package:agora_flutter_quickstart/src/pages/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:agora_flutter_quickstart/src/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:agora_flutter_quickstart/src/authenticate/user.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool loading = false;
  List<Ab> content = [
    Ab(
      image: 'images/bear.png',
    ),
    Ab(
      image: 'images/dog.png',
    ),
    Ab(image: 'images/fox.png'),
    Ab(image: 'images/cow.png'),
    Ab(image: 'images/lio.png'),
    Ab(image: 'images/panda.png'),
    Ab(image: 'images/pig.png'),
    Ab(image: 'images/rab.png'),
    Ab(image: 'images/tig.png'),
  ];
  int currentindex = 0;
  String email;
  String password;
  String error = '';
  String username;
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Center(
                child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 400,
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          onChanged: (val) {
                            setState(() {
                              username = val;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: 'UserName',
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
                          validator: (val) =>
                              val.isEmpty ? 'Enter UserName' : null,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
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
                              ))),
                          validator: (val) => val.length < 8
                              ? 'Enter password 8+ charcter'
                              : null,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Choose avatar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 100,
                          width: 100,
                          child: Center(
                            child: PageView.builder(
                              itemCount: content.length,
                              onPageChanged: (int index) {
                                setState(() {
                                  currentindex = index;
                                });
                              },
                              itemBuilder: (_, i) {
                                return Column(
                                  children: <Widget>[
                                    Image(image: AssetImage(content[i].image)),
                                  ],
                                );
                              },
                            ),
                          ),
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
                              dynamic result = await _auth.registerwithemail(
                                  email,
                                  password,
                                  username,
                                  content[currentindex].image);
                              if (result == null) {
                                setState(() {
                                  error = 'plzz enter valid mail';
                                  loading = false;
                                });
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signemail()),
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
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signemail()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Aldready a user? ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Sign In',
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

class Ac {
  String image;
  Ac({this.image});
}
