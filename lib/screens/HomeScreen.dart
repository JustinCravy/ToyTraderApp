import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toy_trader/firebase_services/DatabaseService.dart';
import 'package:toy_trader/models/ProfileInfo.dart';
import 'package:toy_trader/screens/TradeHistoryScreen.dart';
import 'AddToyScreen.dart';
import 'package:toy_trader/firebase_services/AuthService.dart';
import 'BottomNavBar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int screenIndex = 2;
  AuthService authService = AuthService();
  DatabaseService dbService = DatabaseService();


  @override
  Widget build(BuildContext context) {
    var user = Provider.of<ProfileInfo?>(context);

    return Scaffold(
      // backgroundColor: const Color(0xffC4DFCB),
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Trade History', 'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
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
  void handleClick(String value) async {
    switch (value) {
      case 'Logout':
        await authService.signOut();
        break;
      case 'Trade History':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TradeHistory()),
        );
        break;
    }
  }
}
