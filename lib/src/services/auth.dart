import 'package:agora_flutter_quickstart/src/authenticate/user.dart';
import 'package:agora_flutter_quickstart/src/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userfromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userfromFirebase);
  }

//method to sign in anonamously

  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userfromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign out
  Future SignOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register

  Future registerwithemail(String email, String password, String username,
      String imaageavatar) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      //user information
      await DataBaseService(uid: user.uid)
          .updateUserData(username, imaageavatar);
      return _userfromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sighn in
  Future signinwithemail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userfromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
