import 'package:agora_flutter_quickstart/src/authenticate/user.dart';
import 'package:agora_flutter_quickstart/src/database/room.dart';
import 'package:agora_flutter_quickstart/src/database/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agora_flutter_quickstart/src/authenticate/user.dart';

class DataBaseService {
  final CollectionReference soulsCollection =
      Firestore.instance.collection('name');
  final CollectionReference soulsCollection1 =
      Firestore.instance.collection('room');
  final String uid;
  DataBaseService({this.uid});

  Future updateUserData(String username, String imageavatar) async {
    return await soulsCollection.document(uid).setData({
      'username': username,
      'imageavatar': imageavatar,
    });
  }

  Future CreateRoom(String username, String imageavatar, String description,
      String topic, String channel, String Token) async {
    return await soulsCollection1.document(uid).setData({
      'username': username,
      'imageavatar': imageavatar,
      'description': description,
      'topic': topic,
      'channel': channel,
      'Token': Token,
    });
  }

  //user data from snapshot
  UserData _userdatafromsnap(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      username: snapshot.data['username'],
      imageavatar: snapshot.data['imageavatar'],
    );
  }

  List<Userinfo> getuserinfo(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Userinfo(
        username: doc.data['name'] ?? '',
        iamgeavatar: doc.data['imageavatar'] ?? '',
      );
    });
  }

  Stream<List<Userinfo>> get souls {
    return soulsCollection.snapshots().map(getuserinfo);
  }

  Stream<List<Room>> get room {
    return soulsCollection1.snapshots().map(_roomlistfromsnap);
  }

  List<Room> _roomlistfromsnap(QuerySnapshot snapshot2) {
    return snapshot2.documents.map((doc) {
      return Room(
        username: doc.data['username'] ?? '',
        imageavatar: doc.data['imageavatar'] ?? '',
        topic: doc.data['topic'] ?? '',
        description: doc.data['description'] ?? '',
        channel: doc.data['channel'] ?? '',
        Token: doc.data['Token'] ?? '',
      );
    }).toList();
  }

  Stream<UserData> get userData {
    return soulsCollection.document(uid).snapshots().map(_userdatafromsnap);
  }
}
