import 'package:flutter/cupertino.dart';

import 'MessageBox.dart';

class MessageList extends StatelessWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children:  [
          MessageBox(),
          Text("Item 2", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 3", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 4", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 5", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 6", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 7", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 8", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 1", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 2", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 3", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 4", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 5", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 6", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 7", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 8", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 1", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 2", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 3", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 4", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 5", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 6", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 7", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),
          Text("Item 8", style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center),


        ]
    );
  }
}