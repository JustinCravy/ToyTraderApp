import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toy_trader/screens/TradeDetailsScreen.dart';

import '../firebase_services/DatabaseService.dart';
import '../models/Trade.dart';
import 'HomeScreen.dart';
import 'authentication/SignInScreen.dart';

class TradeHistory extends StatefulWidget {
  const TradeHistory({Key? key}) : super(key: key);

  @override
  State<TradeHistory> createState() => _TradeHistoryState();
}

class _TradeHistoryState extends State<TradeHistory> {
  Widget _body = Center(
    child: CircularProgressIndicator(),
  );
  List<Trade> trades = [];
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    getTrades();
    return _body;
  }

  void handleClick(String value) async {
    switch (value) {
      case 'Logout':
        await FirebaseAuth.instance.signOut();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignInScreen(
                    toggleView: toggleView,
                  )),
        );
        break;
      case 'Trade History':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TradeHistory()),
        );
        break;
    }
  }

  getTrades() async {
    trades = await DatabaseService().getTrades();
    trades.sort((a, b) => b.date.compareTo(a.date));

    setState(() => {
          _body = Scaffold(
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
                title: IconButton(
                  color: Colors.white,
                  iconSize: physicalHeight / 11,
                  icon: Image.asset('assets/images/logo.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                )),

            body: Container(
              child: ListView.builder(
                itemCount: trades.length,
                itemBuilder: (context, i) {
                  return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            (FirebaseAuth.instance.currentUser!.uid ==
                                    trades[i].senderId)
                                ? trades[i].receiverProfileImgUrl
                                : trades[i].senderProfileImgUrl),
                        radius: 25,
                      ),
                      title: Text((FirebaseAuth.instance.currentUser!.uid ==
                              trades[i].senderId)
                          ? trades[i].receiverName
                          : trades[i].senderName),
                      subtitle: Text(trades[i].date),
                      onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TradeDetailsScreen(trade: trades[i])))
                          });
                },
              ),
            ),
          )
        });
  }
}
