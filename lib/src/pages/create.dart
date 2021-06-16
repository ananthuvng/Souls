import 'package:agora_flutter_quickstart/src/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import './call.dart';
import 'dart:async';
import 'package:agora_flutter_quickstart/src/services/database.dart';
import 'package:provider/provider.dart';
import 'package:agora_flutter_quickstart/src/authenticate/user.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  List<TokenGen> content = [
    TokenGen(
      channel: 'abcd',
      Token:
          '006f15a1b2a31434974bc7f38b26a83a990IACHRlTf0OBkAbld3Wy6EeijVGIZQsBYHUZ8V4jgejKeUxHNgu0AAAAAEACbQyLuqnG8YAEAAQCqcbxg',
      flag: false,
    ),
    TokenGen(
      channel: 'abcde',
      Token:
          '006f15a1b2a31434974bc7f38b26a83a990IAC0bdVTyMLxlMzWpmHNYZzV9d5yMFniEtVvjzb1TttV5WXYh4UAAAAAEACbQyLuV3K8YAEAAQBYcrxg',
      flag: false,
    ),
    TokenGen(
      channel: 'abcdef',
      Token:
          '006f15a1b2a31434974bc7f38b26a83a990IACHRlTf0OBkAbld3Wy6EeijVGIZQsBYHUZ8V4jgejKeUxHNgu0AAAAAEACbQyLuqnG8YAEAAQCqcbxg',
      flag: false,
    ),
  ];
  ClientRole _role = ClientRole.Broadcaster;
  String videocat;
  String descri;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<Object>(
        stream: DataBaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return SafeArea(
              child: Scaffold(
                body: Scaffold(
                  backgroundColor: Color.fromRGBO(48, 57, 66, 1),
                  appBar: AppBar(
                    title: Text(
                      'Create A Room',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 29,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    backgroundColor: Color.fromRGBO(48, 57, 66, 1),
                    elevation: 0,
                  ),
                  body: Container(
                    margin: EdgeInsets.all(40),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Chat Topic',
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
                              val.isEmpty ? 'Enter somthing' : null,
                          onChanged: (val) {
                            setState(() {
                              videocat = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Desription',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              fillColor: Color.fromRGBO(39, 106, 116, 1),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color.fromRGBO(254, 137, 58, 1),
                                width: 2,
                              ))),
                          validator: (val) =>
                              val.isEmpty ? 'Enter something' : null,
                          onChanged: (val) {
                            setState(() {
                              descri = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () async {
                            onJoin(
                                'abcdef',
                                '006f15a1b2a31434974bc7f38b26a83a990IADv3tQBa4OC0d9LfSSr7J9gkmsq+DaLwJKbg538TqkcAu85jksAAAAAEACbQyLucnK8YAEAAQBycrxg',
                                _role);
                            await DataBaseService(uid: user.uid).CreateRoom(
                                userData.username,
                                userData.imageavatar,
                                descri,
                                videocat,
                                'abcdef',
                                '006f15a1b2a31434974bc7f38b26a83a990IADv3tQBa4OC0d9LfSSr7J9gkmsq+DaLwJKbg538TqkcAu85jksAAAAAEACbQyLucnK8YAEAAQBycrxg');
                          },
                          child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromRGBO(254, 137, 58, 1),
                              ),
                              child: Center(
                                  child: Text(
                                'Create Room',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  Future<void> onJoin(
    String channel,
    String Token,
    ClientRole _role,
  ) async {
    if (channel.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            Token: Token,
            channelName: channel,
            role: _role,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}

class TokenGen {
  String channel;
  String Token;
  bool flag;
  TokenGen({this.channel, this.flag, this.Token});
}
