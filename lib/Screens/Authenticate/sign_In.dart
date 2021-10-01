import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore/Screens/Home/home.dart';
import 'package:flutter_firestore/Screens/Services/authentication.dart';
import 'package:flutter_firestore/Shared/constants.dart';
import 'package:flutter_firestore/Shared/loading.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}
class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthServices _auth = AuthServices();
  final FirebaseAuth auth = FirebaseAuth.instance;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  // text field state
  String email = '';
  String password = '';
  String error = '';

  String? verificationId;

  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
      await auth.signInWithCredential(phoneAuthCredential);
      _auth.userfromFirebase(authCredential.user!);
      setState(() {
        showLoading = false;
      });

      if(authCredential?.user != null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
      }

    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }

  getMobileFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: phoneController,
          decoration: InputDecoration(
            hintText: "Phone Number",
          ),
        ),
        SizedBox(
          height: 16,
        ),
        FlatButton(
          onPressed: () async {
            setState(() {
              showLoading = true;
            });

            await auth.verifyPhoneNumber(
              phoneNumber: phoneController.text,
              verificationCompleted: (phoneAuthCredential) async {
                setState(() {
                  showLoading = false;
                });
                //signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              verificationFailed: (verificationFailed) async {
                setState(() {
                  showLoading = false;
                });
                _scaffoldKey.currentState!.showSnackBar(
                    SnackBar(content: Text(verificationFailed.message!)));
              },
              codeSent: (verificationId, resendingToken) async {
                setState(() {
                  showLoading = false;
                  currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                  this.verificationId = verificationId;
                });
              },
              codeAutoRetrievalTimeout: (verificationId) async {},
            );
          },
          child: Text("SEND"),
          color: Colors.blue,
          textColor: Colors.white,
        ),
        Spacer(),
      ],
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: otpController,
          decoration: InputDecoration(
            hintText: "Enter OTP",
          ),
        ),
        SizedBox(
          height: 16,
        ),
        FlatButton(
          onPressed: () async {
            PhoneAuthCredential phoneAuthCredential =
            PhoneAuthProvider.credential(
                verificationId: verificationId!, smsCode: otpController.text);

            signInWithPhoneAuthCredential(phoneAuthCredential);
          },
          child: Text("VERIFY"),
          color: Colors.blue,
          textColor: Colors.white,
        ),
        Spacer(),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: showLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
              ? getMobileFormWidget(context)
              : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        ));
    // Scaffold(
    //   backgroundColor: Colors.brown[100],
    //   appBar: AppBar(
    //     backgroundColor: Colors.brown[400],
    //     elevation: 0.0,
    //     title: Text('Sign in to Brew Crew'),
    //     actions: <Widget>[
    //       FlatButton.icon(
    //         icon: Icon(Icons.person),
    //         label: Text('Register'),
    //         onPressed: () => widget.toggleView(),
    //       ),
    //     ],
    //   ),
    //   body: Container(
    //     padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
    //     child: Form(
    //       key: _formkey,
    //       child: Column(
    //         children: <Widget>[
    //           SizedBox(height: 20.0),
    //           TextFormField(
    //             decoration: textInputDecoration.copyWith(hintText: "Enail"),
    //             validator: (val) => val!.isEmpty ? 'Enter an email' : null,
    //             onChanged: (val) {
    //               setState(() => email = val);
    //             },
    //           ),
    //           SizedBox(height: 20.0),
    //           TextFormField(
    //             decoration: textInputDecoration.copyWith(hintText: "Password"),
    //             validator: (val) =>
    //                 val!.length < 6 ? 'Enter password greater than 6' : null,
    //             obscureText: true,
    //             onChanged: (val) {
    //               setState(() => password = val);
    //             },
    //           ),
    //           SizedBox(height: 20.0),
    //           RaisedButton(
    //               color: Colors.pink[400],
    //               child: Text(
    //                 'Sign In',
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //               onPressed: () async {
    //                 if (_formkey.currentState!.validate()) {
    //                   setState(() {
    //                     loading=true;
    //                   });
    //                   dynamic result = await _auth.SignInwithEmailandPassword(
    //                     email,
    //                     password,
    //                   );
    //                   if (result == null) {
    //                     setState(() {
    //                       error = 'Could not Sign In';
    //                       loading =false;
    //                     });
    //                   }
    //                 }
    //               }),
    //           SizedBox(
    //             height: 15,
    //           ),
    //           Text(
    //             error,
    //             style: TextStyle(
    //               color: Colors.red,
    //               fontSize: 13.0,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
