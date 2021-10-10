import 'package:flutter/material.dart';
import 'package:flutter_firestore/Screens/Authenticate/register.dart';
import 'package:flutter_firestore/Screens/Authenticate/sign_In.dart';
import 'package:flutter_firestore/Screens/Authenticate/social_auth.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SocialAuth(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
