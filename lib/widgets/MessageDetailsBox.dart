import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:toy_trader/firebase_services/DatabaseService.dart';
import 'package:toy_trader/models/TextMessage.dart';
import 'package:toy_trader/widgets/MessageDetailsList.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import '../models/ImageMessage.dart';
import '../models/Message.dart';

class MessageDetailsBox extends StatefulWidget {
  final String otherUserId;

  const MessageDetailsBox({Key? key, required this.otherUserId}) : super(key: key);

  @override
  State<MessageDetailsBox> createState() => _MessageDetailsBoxState();
}

class _MessageDetailsBoxState extends State<MessageDetailsBox> {

  DatabaseService dbService = DatabaseService();
  List<Message> messages = [];
  int i = 0;
  @override
  Widget build(BuildContext context)  {
    if(i == 0) {
      getMessages(FirebaseAuth.instance.currentUser!.uid,
          widget.otherUserId);
      i++;
    }

    var textMessage = TextMessage(Uuid().v4(), FirebaseAuth.instance.currentUser!.uid, widget.otherUserId, '', 'TEXT', '');
    var imageMessage = ImageMessage(Uuid().v4(), FirebaseAuth.instance.currentUser!.uid, widget.otherUserId, '', 'IMAGE', '');

    Future pickImage() async{
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage ==null) return;

      final file = File (pickedImage.path);
      await dbService.sendImageMessage(imageMessage, file);
    }


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Username'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GroupedListView<Message, DateTime>(
              padding: const EdgeInsets.all(8),
              reverse: true,
              order: GroupedListOrder.DESC,
              useStickyGroupSeparators: true,
              floatingHeader: true,
              elements: messages,
              groupBy: (message) => DateFormat("yyyy-MM-dd").parse(message.time),
              groupHeaderBuilder: (Message message) => SizedBox(
                  height: 40,
                  child: Center(
                      child: Card(
                          color:Theme.of(context).primaryColor,
                          child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                message.time.substring(0,16),
                                style: const TextStyle(color: Colors.white),
                              )
                          )
                      )
                  )
              ),
              itemBuilder: (context, Message message) => Align(
                alignment: FirebaseAuth.instance.currentUser!.uid == message.senderId
                    ? Alignment.centerRight
                    : Alignment .centerLeft,
                child: Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text((message as TextMessage).message),
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.grey.shade300,
            child: TextField(
              decoration:  InputDecoration(
                contentPadding: EdgeInsets.all(12),
                suffixIcon: IconButton(
                  icon: Icon(Icons.image_outlined),
                  onPressed: () {
                    pickImage();
                  },
                ),
                hintText: 'Type your message here...',
              ),
              onSubmitted: (text) async {

                textMessage.message = text;
                textMessage.time = DateTime.now().toString();
                if(await dbService.sendTextMessage(textMessage)){
                  print('Message sent');
                } else print('failed to send message');


                setState(()=> messages.add(textMessage));
              },
            ),
          ),
        ],
      ),
    );
  }
  getMessages(String userId, String otherUserId) async {
    messages = await DatabaseService().getMessages(userId, otherUserId);
    setState(() => messages);
  }
}
