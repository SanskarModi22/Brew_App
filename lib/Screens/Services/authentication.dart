import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firestore/Models/user.dart';
import 'package:flutter_firestore/Screens/Services/database.dart';
import 'package:flutter/material.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MyUser? userfromFirebase(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  Stream<MyUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => userfromFirebase(user!));
  }
// Future SignInwithPhone(int phoneNo,String verificationId,TextEditingController ph) async{
//     return await _auth.verifyPhoneNumber(
//       phoneNumber: ph.text,
//         verificationCompleted: (phoneAuthCredential) async {
//           setState(() {
//             showLoading = false;
//           });
//           //signInWithPhoneAuthCredential(phoneAuthCredential);
//         },
//         verificationFailed: (verificationFailed) async {
//           setState(() {
//             showLoading = false;
//           });
//           _scaffoldKey.currentState.showSnackBar(
//               SnackBar(content: Text(verificationFailed.message)));
//         },
//         codeSent: (verificationId, resendingToken) async {
//           setState(() {
//             showLoading = false;
//             currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
//             this.verificationId = verificationId;
//           });
//         },
//         codeAutoRetrievalTimeout: (verificationId) async {},
//     );
// }
  Future SignInwithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return userfromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future registerwithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      await DatabaseService(uid: user!.uid).updateUser("0", "Sanskar", 100);
      return userfromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return userfromFirebase(user!);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
