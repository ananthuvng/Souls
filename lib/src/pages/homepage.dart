import 'package:agora_flutter_quickstart/src/database/room.dart';
import 'package:agora_flutter_quickstart/src/database/user.dart';
import 'package:agora_flutter_quickstart/src/pages/room.dart';
import 'package:flutter/material.dart';
import 'package:agora_flutter_quickstart/src/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:agora_flutter_quickstart/src/services/database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Room>>.value(
      value: DataBaseService().room,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Search Rooms',
            style: TextStyle(fontSize: 29),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(Icons.search_sharp),
            )
          ],
          backgroundColor: Color.fromRGBO(48, 57, 66, 1),
          elevation: 0,
        ),
        body:
            Container(padding: EdgeInsets.only(bottom: 20), child: RoomList()),
        backgroundColor: Color.fromRGBO(48, 57, 66, 1),
      ),
    );
  }
}
