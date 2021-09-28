import 'package:flutter/material.dart';
import 'package:flutter_firestore/Screens/Services/authentication.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: Text("SignIn"),
      ),
      body: ElevatedButton(
        child: Text("SignIn Anonymously"),
        onPressed: () async {
          dynamic res = await _auth.signInAnon();
          if (res != null) {
            print("Signed In successfully");
            print(res.uid);
          } else {
            print("error signing in");
          }
        },
      ),
    );
  }
}
