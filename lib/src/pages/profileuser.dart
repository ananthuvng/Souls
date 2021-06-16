import 'package:agora_flutter_quickstart/src/authenticate/user.dart';
import 'package:agora_flutter_quickstart/src/pages/loading.dart';
import 'package:agora_flutter_quickstart/src/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agora_flutter_quickstart/src/services/auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DataBaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return SafeArea(
              child: Scaffold(
                body: CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate(<Widget>[
                        Column(
                          children: [
                            SizedBox(height: 20),
                            SizedBox(height: 20),
                            Container(
                                height: 140,
                                width: 140,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(48, 57, 66, 1),
                                    borderRadius: BorderRadius.circular(600),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(60, 72, 83, 1),
                                        offset: Offset(-4, -4),
                                        spreadRadius: 0,
                                        blurRadius: 7,
                                      ),
                                      BoxShadow(
                                        color: Color.fromRGBO(30, 35, 40, 1),
                                        offset: Offset(4, 4),
                                        spreadRadius: 0,
                                        blurRadius: 5,
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image(
                                    image: AssetImage(userData.imageavatar),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              userData.username,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Logout',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await _auth.SignOut();
                                    },
                                    icon: Icon(Icons.logout),
                                    color: Color.fromRGBO(196, 220, 224, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ],
                ),
                backgroundColor: Color.fromRGBO(48, 57, 66, 1),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
