import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(48, 57, 66, 1),
      child: SpinKitFadingCube(
        color: Color.fromRGBO(254, 137, 58, 1),
        size: 70,
      ),
    );
  }
}
