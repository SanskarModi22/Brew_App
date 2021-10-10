import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/Screens/Home/home.dart';
import 'package:flutter_firestore/Screens/Services/authentication.dart';
import 'package:flutter_firestore/Shared/constants.dart';
import 'package:flutter_firestore/Shared/loading.dart';
class SocialAuth extends StatefulWidget {
  const SocialAuth({Key? key,this.toggleView}) : super(key: key);
  final Function? toggleView;


  @override
  _SocialAuthState createState() => _SocialAuthState();
}

class _SocialAuthState extends State<SocialAuth> {
  final AuthServices _auth = AuthServices();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  // text field state
  String email = '';
  String password = '';
  String error = '';

  String? verificationId;

  bool showLoading = false;
  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () => widget.toggleView!(),
          ),
        ],
      ),
      body: ElevatedButton(
child: Text("Sign In with Google"),
        onPressed: () async {
          dynamic result = await _auth.signInWithGoogle();

                              if (result == null) {
                                setState(() {
                                  error = 'Could not Sign In';
                                  loading =false;
                                });
                              }
        },
      ),
      // body: Container(
      //   padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      //   child: Form(
      //     key: _formkey,
      //     child: Column(
      //       children: <Widget>[
      //         SizedBox(height: 20.0),
      //         TextFormField(
      //           decoration: textInputDecoration.copyWith(hintText: "Enail"),
      //           validator: (val) => val!.isEmpty ? 'Enter an email' : null,
      //           onChanged: (val) {
      //             setState(() => email = val);
      //           },
      //         ),
      //         SizedBox(height: 20.0),
      //         TextFormField(
      //           decoration: textInputDecoration.copyWith(hintText: "Password"),
      //           validator: (val) =>
      //               val!.length < 6 ? 'Enter password greater than 6' : null,
      //           obscureText: true,
      //           onChanged: (val) {
      //             setState(() => password = val);
      //           },
      //         ),
      //         SizedBox(height: 20.0),
      //         RaisedButton(
      //             color: Colors.pink[400],
      //             child: Text(
      //               'Sign In',
      //               style: TextStyle(color: Colors.white),
      //             ),
      //             onPressed: () async {
      //               if (_formkey.currentState!.validate()) {
      //                 setState(() {
      //                   loading=true;
      //                 });
      //                 dynamic result = await _auth.SignInwithEmailandPassword(
      //                   email,
      //                   password,
      //                 );
      //                 if (result == null) {
      //                   setState(() {
      //                     error = 'Could not Sign In';
      //                     loading =false;
      //                   });
      //                 }
      //               }
      //             }),
      //         SizedBox(
      //           height: 15,
      //         ),
      //         Text(
      //           error,
      //           style: TextStyle(
      //             color: Colors.red,
      //             fontSize: 13.0,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
