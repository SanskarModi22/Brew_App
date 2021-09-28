import 'package:flutter/material.dart';
import 'package:flutter_firestore/Screens/Authenticate/sign_In.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}
