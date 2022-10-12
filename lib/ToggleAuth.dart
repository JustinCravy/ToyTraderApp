import 'package:flutter/material.dart';
import 'package:toy_trader/screens/authentication/RegistrationScreen.dart';
import 'package:toy_trader/screens/authentication/SignInScreen.dart';

class ToggleAuth extends StatefulWidget {
  const ToggleAuth({Key? key}) : super(key: key);

  @override
  State<ToggleAuth> createState() => _ToggleAuthState();
}

class _ToggleAuthState extends State<ToggleAuth> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }
  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInScreen(toggleView: toggleView);
    } else {
      return RegistrationScreen(toggleView: toggleView);
    }
  }
}