import 'package:agora_flutter_quickstart/src/database/room.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './call.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';

class RoomList extends StatefulWidget {
  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  ClientRole _role = ClientRole.Broadcaster;
  @override
  Widget build(BuildContext context) {
    final rooms = Provider.of<List<Room>>(context);
    var k = 0;
    var arr = new List(10);
    for (int j = 0; j < rooms.length; j++) {
      if (rooms[j].username.isNotEmpty) {
        k++;
        print(j);
        arr[k - 1] = j;
      }
    }
    return ListView.builder(
        itemCount: k,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(9),
            decoration: BoxDecoration(
                color: Color.fromRGBO(39, 106, 116, 1),
                borderRadius: BorderRadius.circular(30),
                boxShadow: []),
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Text(
                          '${rooms[arr[index]].topic}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.description,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 18, right: 45, top: 2, bottom: 0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Text(
                          '${rooms[arr[index]].description}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 17, right: 15, top: 10, bottom: 20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 60,
                          height: 60,
                          child: Image(
                            image: AssetImage(rooms[arr[index]].imageavatar),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          '  @ ${rooms[arr[index]].username}',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            onJoin(rooms[arr[index]].channel,
                                rooms[arr[index]].Token, _role);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(196, 220, 224, 1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            width: 70,
                            height: 30,
                            child: Center(
                              child: Text(
                                'JOIN',
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
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
