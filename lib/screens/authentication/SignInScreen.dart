import 'package:flutter/material.dart';

import '../../firebase_services/AuthService.dart';

class SignInScreen extends StatefulWidget {
  final Function toggleView;

  const SignInScreen({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String pw = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color(0xffC4DFCB),
        appBar: AppBar(
            title: const Text(
              "Toy Trader",
              style: TextStyle(
                // color: Theme.of(context).primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: <Widget>[
              TextButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ))
            ]
            // backgroundColor: Colors.white,
            ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Column(children: <Widget>[
                  Image.asset('assets/images/logo.png',
                      width: 350, height: 175),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Email',
                          ),
                          validator: (val) => val!.isEmpty ? 'Email must not be empty' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            }
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Password',
                            ),
                            validator: (val) => val!.length < 2
                                ? 'Password must be > 2 chars'
                                : null,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() => pw = val);
                            }),
                        SizedBox(height: 20.0),
                        TextButton(
                            child: Text('Sign in'),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                dynamic result =
                                    await authService.signIn(email, pw);
                                if (result == null) {
                                  setState(() => error = 'Couldnt sign in...');
                                }
                              }
                            }),
                        SizedBox(height: 20.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        )
                      ],
                    ),
                  ),
                ]))));
  }
}
