import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toy_trader/screens/TradeDetailsScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_services/DatabaseService.dart';
import '../models/Trade.dart';
import 'HomeScreen.dart';

class TradeHistory extends StatefulWidget {
  const TradeHistory({Key? key}) : super(key: key);

  @override
  State<TradeHistory> createState() => _TradeHistoryState();
}

class _TradeHistoryState extends State<TradeHistory> {
  List<Trade> trades = [];

  @override
  Widget build(BuildContext context) {
    getTrades();
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
          title: IconButton(
            color: Colors.white,
            iconSize: physicalHeight / 11,
            icon: Image.asset('assets/images/logo.png'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          )
      ),

      body: Container(
        child: ListView.builder(
          itemCount: trades.length,
          itemBuilder: (context, i) {
            return ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                  NetworkImage(trades[i].receiverProfileImgUrl),
                  radius: 25,
                ),
                title: Text(trades[i].receiverName),
                subtitle: Text(trades[i].date),
                onTap: () => {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => TradeDetailsScreen(trade: trades[i])
                  )
                )
            });
          },
        ),
      ),
    );
  }

  void handleClick(String value) async {
    switch (value) {
      case 'Logout':
        await FirebaseAuth.instance.signOut();
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
    setState(() => trades);
  }
}
