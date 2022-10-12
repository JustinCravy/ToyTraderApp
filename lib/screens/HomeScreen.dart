import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toy_trader/models/ProfileInfo.dart';
import 'BottomNavBar.dart';
import 'package:toy_trader/firebase_services/AuthService.dart';

import 'authentication/SignInScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int screenIndex = 2;
  AuthService authService = AuthService();


  @override
  Widget build(BuildContext context) {
    final profileInfo = ModalRoute.of(context)!.settings.arguments as ProfileInfo?;

    return Scaffold(
      // backgroundColor: const Color(0xffC4DFCB),
      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async{
                await authService.signOut();
              },
                icon:
                Icon(Icons.person, color: Colors.white,)
                ,
                label: Text('Logout', style: TextStyle(color: Colors.white),),

          )
        ],
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
      body: (() {
        if(screenIndex == 0) {
          return ConversationsScreen();
        } else if( screenIndex == 1) {
          return ProfileScreen();
        } else {
          return MainScreen();
        }
      }()),      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  screenIndex = 0;
                });
              },
              icon: screenIndex == 0
                  ? const Icon(
                Icons.message_rounded,
                color: Colors.white,
                size: 35,
              )
                  : const Icon(
                Icons.message_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  screenIndex = 2;
                });
              },
              icon: screenIndex == 2
                  ? const Icon(
                Icons.home_rounded,
                color: Colors.white,
                size: 35,
              )
                  : const Icon(
                Icons.home_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  screenIndex = 1;
                });
              },
              icon: screenIndex == 1
                  ? const Icon(
                Icons.person_rounded,
                color: Colors.white,
                size: 35,
              )
                  : const Icon(
                Icons.person_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
