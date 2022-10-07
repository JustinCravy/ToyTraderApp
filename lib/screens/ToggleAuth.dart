import 'package:flutter/material.dart';
import 'package:toy_trader/screens/authentication/RegistrationScreen.dart';
import 'package:toy_trader/screens/authentication/SignInScreen.dart';

class ToggleAuth extends StatefulWidget {

  @override
  _ToggleAuth createState() => _ToggleAuth();
}

class _ToggleAuth extends State<ToggleAuth> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInScreen(toggleView: toggleView,);
    } else {
      return RegistrationScreen(toggleView: toggleView);
    }
  }
}