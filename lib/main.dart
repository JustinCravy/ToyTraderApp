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

    //Creates a Custom Color That can be added to the theme of the app,
    //The first three fields (R,G,B,Opacity);
    MaterialColor mycolor = MaterialColor(const Color.fromRGBO(162,156,244, 1).value, const <int, Color>{
      50: Color.fromRGBO(162,156,244, 0.1),
      100: Color.fromRGBO(162,156,244,  0.2),
      200: Color.fromRGBO(162,156,244, 0.3),
      300: Color.fromRGBO(162,156,244,  0.4),
      400: Color.fromRGBO(162,156,244,  0.5),
      500: Color.fromRGBO(162,156,244,  0.6),
      600: Color.fromRGBO(162,156,244,0.7),
      700: Color.fromRGBO(162,156,244,  0.8),
      800: Color.fromRGBO(162,156,244, 0.9),
      900: Color.fromRGBO(162,156,244, 1),
    },
    );
    return StreamProvider<ProfileInfo?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'Toy Trader',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: mycolor),

        home:  AuthWrapper()
      ),
    );
  }

}
