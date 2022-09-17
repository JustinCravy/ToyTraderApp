import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/MessageList.dart';

class MessageTabScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child:Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
          title: const TabBar(
            tabs: [
              Tab(text: "Inbox"),
              Tab(text: "Sent")
            ]
          )
        ),
        body:  TabBarView(children: <Widget>[
          Center(
            child: MessageList(),
          ),
          Center(
            child: Text("You have no sent messages.")
          ),
        ])

      ),
    );
  }

}