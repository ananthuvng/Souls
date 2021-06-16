import 'dart:io';

import 'package:agora_flutter_quickstart/src/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:agora_flutter_quickstart/src/services/auth.dart';

class Settingsuser extends StatefulWidget {
  @override
  _SettingsuserState createState() => _SettingsuserState();
}

class _SettingsuserState extends State<Settingsuser> {
  bool loading = false;
  final AuthService _auth = AuthService();
  bool dark = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: dark ? Colors.black : Colors.white,
            body: Column(
              children: <Widget>[
                SizedBox(height: 20),
                SizedBox(height: 20),
                RaisedButton(onPressed: () {
                  setState(() {
                    dark = !dark;
                  });
                }),
                IconButton(
                  onPressed: () async {
                    await _auth.SignOut();
                  },
                  icon: Icon(Icons.logout),
                )
              ],
            ),
          );
  }
}
