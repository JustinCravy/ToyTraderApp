import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toy_trader/models/Conversation.dart';
import 'package:toy_trader/widgets/ToyBox.dart';
import '../firebase_services/AuthService.dart';

import '../firebase_services/DatabaseService.dart';
import 'MessageBox.dart';

class MessageList extends StatefulWidget {


  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList>{

  AuthService authService = AuthService();
  DatabaseService dbS = DatabaseService();





  @override
  Widget build(BuildContext context) {
   Conversation t1 = Conversation('0', 'Hey how we doin', '3');
   Conversation t2 = Conversation('1', 'How long until my toy is shipped.', '3');
   Conversation t3 = Conversation('2', 'Are we going to trade?', '3');

   List<Conversation> convo = [];
   List<Widget> widgetList = [];

   convo.add(t1);
   convo.add(t2);
   convo.add(t3);

   convo.add(t1);
   convo.add(t2);
   convo.add(t3);
   convo.add(t1);
   convo.add(t2);
   convo.add(t3);
   convo.add(t1);
   convo.add(t2);
   convo.add(t3);
   convo.add(t1);
   convo.add(t2);
   convo.add(t3);



   if(convo.isEmpty){
     return showEmptyConversations();
   }
   else{
     for(var c in convo){
       widgetList.add(MessageBox(convo: c,));
     }
     return showConversations(widgetList);
   }

  }

  Widget showConversations(List<Widget> widgetList) {
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: ShaderMask(
            shaderCallback: (Rect rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blueAccent, Colors.transparent, Colors.transparent, Colors.blueAccent],
                stops: [0.0, 0.05, 0.95, 1.0],
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child:ListView(
                shrinkWrap: true,
                children: widgetList
            )
        )


    );
  }
}

 showEmptyConversations() {
   return Text('You have no Messages');
 }