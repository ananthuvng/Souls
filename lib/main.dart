import 'package:agora_flutter_quickstart/src/authenticate/user.dart';
import 'package:agora_flutter_quickstart/src/services/auth.dart';
import 'package:agora_flutter_quickstart/wrapper.dart';
import 'package:flutter/material.dart';
import 'wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
