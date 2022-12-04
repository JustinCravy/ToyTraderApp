import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toy_trader/models/Conversation.dart';
import 'package:toy_trader/widgets/MyBehavior.dart';

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
  Widget _body = CircularProgressIndicator();
  List<Widget> widgetList = [];






  @override
  Widget build(BuildContext context) {
    showConversations(widgetList);

    conversations.sort((a, b) => a.time.compareTo(b.time));

    for (var c in conversations.reversed) {
      widgetList.add(MessageBox(
        convo: c,
      ));
    }
    return _body;

  }


  Widget showConversations(List<Widget> widgetList) {
    if (i == 0) {
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
                stops: [0.0, 0.05, 2.0, 1.0],
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView(shrinkWrap: true, children: widgetList)
            )

        )
    );
  }


  getConversations() async {
    conversations =
    await dbS.getConversations(AuthService().firebaseAuth.currentUser!.uid);
    setState(() => {
    if(conversations.isEmpty)
      _body = showEmptyConversations()
      else
        _body = showConversations(widgetList)
    });
}

  showEmptyConversations() {
    return Column(
      children: const [
        SizedBox(
          width: double.infinity,
          height: 200,
        ),
        Icon(Icons.inbox, size:100.0, color: Colors.grey,),
         Text(
        'You have no Messages',
    style: TextStyle(fontSize:29,),
         ),
      ],
    );

  }
}