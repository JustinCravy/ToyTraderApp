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
        ),        actions: <Widget>[
        FlatButton.icon(
            onPressed: () {
              
            },
            icon: Icon(Icons.person),
            label: Text('Register'))
      ]
        // backgroundColor: Colors.white,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox( height: 20.0),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (val) => val!.isEmpty ? 'Enter email' : null,
                ),
                SizedBox( height: 20.0),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (val) => val!.length < 2 ? 'Password must be > 2 chars' : null,
                    obscureText: true,
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    child: Text('Sign in'),
                    onPressed: ()  {

                    }
                ),
              ],
            ),
          )
      )
    );
  }
}
