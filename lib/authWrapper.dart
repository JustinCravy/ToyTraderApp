import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:toy_trader/models/ProfileInfo.dart';
import 'package:toy_trader/screens/HomeScreen.dart';
import 'package:toy_trader/ToggleAuth.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<ProfileInfo?>(context);
    print(user?.userId);

    // return authenticate or home
    if(user == null) {
      return ToggleAuth();
    } else {
      return HomeScreen();
    }
  }
}