import 'package:flutter/material.dart';
import 'package:toy_trader/screens/authentication/QuestionnaireScreen.dart';

class RegistrationScreen extends StatefulWidget {
  final Function toggleView;

  const RegistrationScreen({Key? key, required this.toggleView})
      : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String pw = '';
  List<String> args = ['', ''];
  String confirmPw = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color(0xffC4DFCB),
        appBar: AppBar(
          title: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 50, 0),
              child: Image.asset('assets/images/logo.png')),

          actions: <Widget>[
            Directionality(
                textDirection: TextDirection.rtl,
                child: TextButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white),
                    )))
          ],
          // centerTitle: true,
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
                            validator: (val) =>
                                val!.isEmpty ? 'Email must not be empty' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            }),
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
                        TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                            ),
                            validator: (val) =>
                                val! != pw ? 'Passwords must match' : null,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() => confirmPw = val);
                            }),
                        SizedBox(height: 60.0),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.fromLTRB(50, 10, 50, 10),
                                elevation: 12.0,
                                textStyle: const TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            child: const Text('Register'),
                            onPressed: () {
                              args[0] = email;
                              args[1] = pw;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          QuestionnaireScreen(),
                                      settings:
                                          RouteSettings(arguments: args)));
                            }),
                        const SizedBox(height: 20.0),
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
