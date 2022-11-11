import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toy_trader/models/Conversation.dart';

import '../firebase_services/AuthService.dart';
import '../firebase_services/DatabaseService.dart';
import 'MessageBox.dart';

class MessageList extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  AuthService authService = AuthService();
  DatabaseService dbS = DatabaseService();
  List<Conversation> conversations = [];
  int i = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];

    for (var c in conversations) {
      widgetList.add(MessageBox(
        convo: c,
      ));
    }
    return showConversations(widgetList);
  }

  Widget showConversations(List<Widget> widgetList) {
    if(i == 0) {
      getConversations();
      i++;
    }

    return Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: ShaderMask(
            shaderCallback: (Rect rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blueAccent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.blueAccent
                ],
                stops: [0.0, 0.05, 0.95, 1.0],
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: ListView(shrinkWrap: true, children: widgetList)));
  }

  getConversations() async {
    conversations =
        await dbS.getConversations(AuthService().firebaseAuth.currentUser!.uid);
    setState(() => conversations);
  }
}

showEmptyConversations() {
  return Text('You have no Messages');
}
