import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toy_trader/authWrapper.dart';
import 'package:toy_trader/firebase_services/AuthService.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/ProfileInfo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ProfileInfo?>.value(
      value: AuthService().user,
      initialData: null,
      child: const MaterialApp(
        title: 'Toy Trader',
        debugShowCheckedModeBanner: false,
        home:  AuthWrapper()
      ),
    );
  }
}
