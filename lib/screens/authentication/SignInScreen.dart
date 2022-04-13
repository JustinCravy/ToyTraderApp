import 'package:flutter/material.dart';
import '../HomeScreen.dart';
import 'RegistrationScreen.dart';

class SignInScreen extends StatelessWidget{
  const SignInScreen({Key? key}) : super(key: key);

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
                  "Login Screen",
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 45,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 20.0),
                RaisedButton(
                    child: const Text('To Registration'),
                    onPressed: ()  {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationScreen()));
                    }
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    child: const Text('Login'),
                    onPressed: ()  {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                    }
                ),
              ],
            )
        ),
      ),
    );
  }
}
