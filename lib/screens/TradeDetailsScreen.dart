import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toy_trader/firebase_services/DatabaseService.dart';
import 'package:toy_trader/models/ProfileInfo.dart';

import '../models/AppColors.dart';
import '../models/Trade.dart';
import '../widgets/ToyBox.dart';
import 'HomeScreen.dart';
import 'RateUserScreen.dart';
import 'TradeHistoryScreen.dart';
import 'authentication/SignInScreen.dart';

class TradeDetailsScreen extends StatefulWidget {
  final Trade trade;

  const TradeDetailsScreen({Key? key, required this.trade}) : super(key: key);

  @override
  State<TradeDetailsScreen> createState() => _TradeDetailsScreenState();
}

class _TradeDetailsScreenState extends State<TradeDetailsScreen> {
  bool showSignIn = true;
  String dropdownValue = '';

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            )),
        body: Container(
            alignment: Alignment.center,
            //Set container alignment  then wrap the column with singleChildScrollView
            child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 30.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          const TextSpan(text: 'Trade Status: '),
                          TextSpan(
                              text: widget.trade.tradeStatus,
                              style: const TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      'Sender: ${widget.trade.senderName}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: ListView.builder(
                          itemCount: widget.trade.senderToys.length,
                          itemBuilder: (context, i) {
                            return ListTile(
                                leading: CircleAvatar(
                                  child: Image.network(
                                    widget.trade.senderToys[i].toyImageURL,
                                    fit: BoxFit.contain,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  radius: 25,

                                ),
                                title: Text(widget.trade.senderToys[i].name),
                                subtitle: Text(
                                    widget.trade.senderToys[i].description),
                                onTap: () => {});
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Receiver: ${widget.trade.receiverName}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20))),
                        child: ListView.builder(
                          itemCount: widget.trade.receiverToys.length,
                          itemBuilder: (context, i) {
                            return ListTile(
                                leading: CircleAvatar(
                                  child: Image.network(
                                      widget.trade.receiverToys[i].toyImageURL,
                                    fit: BoxFit.contain,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  radius: 25,
                                ),
                                title: Text(widget.trade.receiverToys[i].name),
                                subtitle: Text(
                                    widget.trade.receiverToys[i].description),
                                onTap: () =>
                                {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => const TradeDetailsScreen()),
                                  // )
                                });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    if(widget.trade.senderId ==
                        FirebaseAuth.instance.currentUser!.uid && widget.trade.tradeStatus == 'Pending')
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(45),
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                height: deviceHeight(context) * .07,
                                width: deviceWidth(context) * .40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: AppColors.prussianBlue,
                                  borderRadius: BorderRadius.all(Radius
                                      .circular(30)),
                                ),
                                child: Center(
                                    child: Text(
                                      "Cancel Trade",
                                      style: new TextStyle(
                                          fontSize: 25.0, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                              onTap: () async {
                                widget.trade.tradeStatus = 'Cancelled';
                                await DatabaseService().updateTrade(widget.trade);
                                setState(() {

                                });
                              },
                            )
                          ]),

                    if(widget.trade.senderId !=
                        FirebaseAuth.instance.currentUser!.uid && widget.trade.tradeStatus == 'Pending' )
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(45),
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                height: deviceHeight(context) * .07,
                                width: deviceWidth(context) * .40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: AppColors.prussianBlue,
                                  borderRadius: BorderRadius.all(Radius
                                      .circular(30)),
                                ),
                                child: Center(
                                    child: Text(
                                      "Accept Trade",
                                      style: new TextStyle(
                                          fontSize: 25.0, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                              onTap: () async {
                                widget.trade.tradeStatus = 'Accepted';
                                await DatabaseService().updateTrade(widget.trade);
                                setState(() {

                                });
                              },
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(45),
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                height: deviceHeight(context) * .07,
                                width: deviceWidth(context) * .40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: AppColors.prussianBlue,
                                  borderRadius: BorderRadius.all(Radius
                                      .circular(30)),
                                ),
                                child: Center(
                                    child: Text(
                                      "Reject Trade",
                                      style: new TextStyle(
                                          fontSize: 25.0, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                              onTap: () async {
                                widget.trade.tradeStatus = 'Rejected';
                                await DatabaseService().updateTrade(widget.trade);
                                setState(() {

                                });
                              },
                            )
                          ]),
                    if(widget.trade.senderId ==
                        FirebaseAuth.instance.currentUser!.uid && widget.trade.tradeStatus == 'Accepted' && !widget.trade.senderRatingRcvd)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(45),
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                height: deviceHeight(context) * .07,
                                width: deviceWidth(context) * .40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: AppColors.prussianBlue,
                                  borderRadius: BorderRadius.all(Radius
                                      .circular(30)),
                                ),
                                child: Center(
                                    child: Text(
                                      "Rate User",
                                      style: new TextStyle(
                                          fontSize: 25.0, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                              onTap: () async {
                                 Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => RateUserScreen(id: widget.trade.receiverId, trade: widget.trade)),
                                 );
                              },
                            )
                          ]),
                    if(widget.trade.receiverId ==
                        FirebaseAuth.instance.currentUser!.uid && widget.trade.tradeStatus == 'Accepted' && !widget.trade.receiverRatingRcvd)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(45),
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                height: deviceHeight(context) * .07,
                                width: deviceWidth(context) * .40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: AppColors.prussianBlue,
                                  borderRadius: BorderRadius.all(Radius
                                      .circular(30)),
                                ),
                                child: Center(
                                    child: Text(
                                      "Rate User",
                                      style: new TextStyle(
                                          fontSize: 25.0, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                              onTap: () async {
                                String id;
                                if(FirebaseAuth.instance.currentUser!.uid == widget.trade.senderId)
                                  id = widget.trade.receiverId;
                                else id = widget.trade.senderId;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RateUserScreen(id: id, trade: widget.trade,)),
                                );

                              },
                            )
                          ]),

                  ]),
            )));
  }

  void handleClick(String value) async {
    switch (value) {
      case 'Logout':
        await FirebaseAuth.instance.signOut();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SignInScreen(
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
}
