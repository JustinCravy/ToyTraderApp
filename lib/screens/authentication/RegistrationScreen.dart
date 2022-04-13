import 'package:flutter/material.dart';
import 'package:toy_trader/screens/QuestionnaireScreen.dart';
import 'package:toy_trader/screens/authentication/SignInScreen.dart';
import '../HomeScreen.dart';

class RegistrationScreen extends StatelessWidget{
  const RegistrationScreen({Key? key}) : super(key: key);

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
        // color: const Color(0xffC4DFCB),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Registration Screen",
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    child: const Text('To Questionnaire'),
                    onPressed: ()  {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const QuestionnaireScreen()));
                    }
                ),
              ],
            )
        ),
      ),
    );
  }
}
