import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toy_trader/screens/authentication/AuthService.dart';
import 'BottomNavBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService authService = AuthService();
  int screenIndex = 2;

  final screens = [
    const MessagesScreen(),
    const MainScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffC4DFCB),
      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                await
                authService.signOut();
              },
              icon: Icon(Icons.person, color: Colors.white,),
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
      body: screens[screenIndex],
      bottomNavigationBar: Container(
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
