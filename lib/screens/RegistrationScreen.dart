import 'package:flutter/material.dart';
import 'package:toy_trader/screens/authentication/QuestionnaireScreen.dart';
import 'package:toy_trader/screens/authentication/SignInScreen.dart';
import '../HomeScreen.dart';

class RegistrationScreen extends StatelessWidget{
  // const RegistrationScreen({Key? key}) : super(key: key);
  final Function toggleView;
  RegistrationScreen({required this.toggleView});

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
        // centerTitle: true,
        // backgroundColor: Colors.white,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          // color: const Color(0xffC4DFCB),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0,10,0,5),
                child: Image.asset(
                    'assets/images/logo.png',
                    width: 200,
                    height: 200
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5),
                child: SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email',
                    ),
                  ),
                  height: 60,
                  width: 350,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5),
                child: SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Choose Password',
                    ),
                  ),
                  height: 60,
                  width: 350,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5),
                child: SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Confirm Password',
                    ),
                  ),
                  height: 60,
                  width: 350,
                ),
              ),
              const Text(
                "*Has at least 8 characters",
                style: TextStyle(
                    fontSize: 12
                ),
              ),
              const Text(
                "*Has at least 1 number",
                style: TextStyle(
                    fontSize: 12
                ),
              ),
              const SizedBox(height: 20.0),
              RaisedButton(
                  child: const Text('Sign Up'),
                  onPressed: ()  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionnaireScreen()));
                  }),
              RaisedButton(
                  child: const Text('Back to Sign in'),
                  onPressed: ()  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen(toggleView: toggleView,)));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
