import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toy_trader/screens/BottomNavBar.dart';
import '../widgets/MessageList.dart';

class ConversationsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SingleChildScrollView(
                child: MessageList(),
              )
          ],
        ),
      ),
    );
  }
}