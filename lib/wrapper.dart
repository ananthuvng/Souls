import 'package:agora_flutter_quickstart/home.dart';
import 'package:agora_flutter_quickstart/src/authenticate/authenticate.dart';
import 'package:agora_flutter_quickstart/src/authenticate/user.dart';
import 'package:agora_flutter_quickstart/src/pages/email.dart';
import 'package:flutter/material.dart';
import 'package:agora_flutter_quickstart/src/pages/sign_in.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  bool showsignin = true;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
