import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Trade.dart';
import 'RateUserScreen.dart';

class TradeDetailsScreen extends StatefulWidget {
  final Trade trade;

  const TradeDetailsScreen({Key? key, required this.trade}) : super(key: key);

  @override
  State<TradeDetailsScreen> createState() => _TradeDetailsScreenState();
}

class _TradeDetailsScreenState extends State<TradeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Trade Details",
          style: TextStyle(
            // color: Theme.of(context).primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: new TextSpan(
                style: new TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(text: 'Trade Status: '),
                  new TextSpan(
                      text: widget.trade.tradeStatus,
                      style: new TextStyle(
                          fontSize: 30.0,
                          color: Colors.green,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              'Sender: ' + widget.trade.senderName,
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: double.infinity,
              height: 150,
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 3)),
              child: ListView.builder(
                itemCount: widget.trade.senderToys.length,
                itemBuilder: (context, i) {
                  return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            widget.trade.senderToys[i].toyImageURL),
                        radius: 25,
                      ),
                      title: Text(widget.trade.senderToys[i].name),
                      subtitle: Text(widget.trade.senderToys[i].description),
                      onTap: () => {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const TradeDetailsScreen()),
                            // )
                          });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Receiver: ' + widget.trade.receiverName,
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: double.infinity,
              height: 150,
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 3)),
              child: ListView.builder(
                itemCount: widget.trade.receiverToys.length,
                itemBuilder: (context, i) {
                  return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            widget.trade.receiverToys[i].toyImageURL),
                        radius: 25,
                      ),
                      title: Text(widget.trade.receiverToys[i].name),
                      subtitle: Text(widget.trade.receiverToys[i].description),
                      onTap: () => {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const TradeDetailsScreen()),
                            // )
                          });
                },
              ),
            ),
            TextButton(
                child: const Text('Rate the user'),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder:(context)=> RateUserScreen(
                          id:widget.trade.receiverId,
                        )
                    )
                  );
                }),
          ]),
    );
  }
}
