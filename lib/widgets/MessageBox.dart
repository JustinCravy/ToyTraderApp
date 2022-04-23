import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:toy_trader/screens/MessageDetailsScreen.dart';

class MessageBox extends StatefulWidget {
  @override
  State<MessageBox> createState() => _MessageBoxState();

}

class _MessageBoxState extends State<MessageBox>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
          child: Container(
            child: const Text("Message Details", style:  TextStyle(fontSize: 40),
                textAlign: TextAlign.center),
          ),
          onTap:(){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MessageDetailsScreen())
            );
          }
      ),
    );
  }
}

