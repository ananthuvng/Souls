import 'package:agora_flutter_quickstart/src/pages/create.dart';
import 'package:agora_flutter_quickstart/src/pages/profileuser.dart';
import 'package:agora_flutter_quickstart/src/pages/homepage.dart';
import 'package:agora_flutter_quickstart/src/pages/settingsuser.dart';
import 'package:agora_flutter_quickstart/src/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final List<Widget> children = [
    HomePage(),
    Create(),
    Profile(),
  ];

  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.add, size: 30),
          Icon(Icons.person, size: 30),
        ],
        color: Color.fromRGBO(254, 137, 58, 1),
        buttonBackgroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(48, 57, 66, 1),
        animationCurve: Curves.easeInQuad,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: children[_page],
      backgroundColor: Color.fromRGBO(46, 57, 66, 1),
    );
  }
}
