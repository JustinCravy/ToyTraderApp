import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toy_trader/screens/TradeDetailsScreen.dart';

import '../firebase_services/DatabaseService.dart';
import '../models/Trade.dart';

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
        title: const Text(
          "Trade History",
          style: TextStyle(
            // color: Theme.of(context).primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
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

  getTrades() async {
    trades = await DatabaseService().getTrades();
    setState(() => trades);
  }
}
