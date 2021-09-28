import 'package:flutter/material.dart';
import 'package:flutter_firestore/Models/user.dart';
import 'package:flutter_firestore/Screens/Authenticate/Sign_In.dart';
import 'package:provider/provider.dart';

import 'Screens/Authenticate/auth.dart';

// import 'Screens/Home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print(user);
    return Auth();
  }
}
