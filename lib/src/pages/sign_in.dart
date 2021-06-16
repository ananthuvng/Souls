import 'package:agora_flutter_quickstart/src/pages/email.dart';
import 'package:agora_flutter_quickstart/src/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  List<Ab> content = [
    Ab(
        image: 'images/ma.svg',
        text:
            'Find the people having same intrests could be hard somtimes\nAnd in this pandemic it is even harder ',
        title: 'Hello Folks'),
    Ab(
        image: 'images/ga.svg',
        text:
            'here is an App which will help you to find people with same intrests from all around the world',
        title: 'Be happy'),
  ];
  int currentindex = 0;
  bool showsignin = true;
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: PageView.builder(
              itemCount: 2,
              onPageChanged: (int index) {
                setState(() {
                  currentindex = index;
                });
              },
              itemBuilder: (_, i) {
                return Column(
                  children: <Widget>[
                    Expanded(
                      flex: 10,
                      child: Container(
                          margin: EdgeInsets.only(bottom: 0),
                          child: SvgPicture.asset(content[i].image)),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        content[i].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Expanded(
                      flex: 3,
                      child: Text(
                        content[i].text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      2, (index) => buildCont(currentindex, index, context)))),
          Expanded(
            flex: 1,
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Signemail()),
                  );
                },
                child: Container(
                  height: 40,
                  width: 100,
                  child: Center(
                      child: Text(
                    'Lets go',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    color: Color.fromRGBO(254, 137, 58, 1),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Color.fromRGBO(48, 57, 66, 1),
    );
  }
}

Container buildCont(int currentindex, int index, BuildContext context) {
  return Container(
    height: 10,
    width: currentindex == index ? 30 : 10,
    margin: EdgeInsets.only(right: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color.fromRGBO(254, 137, 58, 1),
    ),
  );
}

class Ab {
  String image;
  String text;
  String title;
  Ab({this.image, this.title, this.text});
}
