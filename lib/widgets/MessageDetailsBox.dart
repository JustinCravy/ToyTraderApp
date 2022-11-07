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

import '../models/Message.dart';

class MessageDetailsBox extends StatefulWidget {
  @override
  State<MessageDetailsBox> createState() => _MessageDetailsBoxState();
}

class _MessageDetailsBoxState extends State<MessageDetailsBox> {



  List<MessageDetailsList> messages = [

    MessageDetailsList(
      text: 'Sure lets trade!',
      date: DateTime.now().subtract(
        const Duration(days: 1, minutes: 30),
      ),
      isSentByMe: false,
    ),
    MessageDetailsList(
        text: 'Would you like to trade?',
        date: DateTime.now().subtract(
          const Duration(days: 1, minutes: 50),
        ),
        isSentByMe: true
    ),
    MessageDetailsList(
      text: 'Thanks I got my eye on that toy tractor.',
      date: DateTime.now().subtract(
        const Duration(days: 1, minutes: 55),
      ),
      isSentByMe: false,
    ),
    MessageDetailsList(
        text: 'Here is my adress ... thanks for a good trade!',
        date: DateTime.now().subtract(
          const Duration(minutes: 60),
        ),
        isSentByMe: true
    ),
    MessageDetailsList(
        text: 'You can send the toy here.. where should I send yours?',
        date: DateTime.now().subtract(
          const Duration(minutes: 50),
        ),
        isSentByMe: false
    ),
    MessageDetailsList(
        text: 'Hey I like that Nerf gun you have.',
        date: DateTime.now().subtract(
          const Duration(days: 1, minutes: 70),
        ),
        isSentByMe: true)
  ].reversed.toList();

  @override
  Widget build(BuildContext context) {

    DatabaseService dbService = DatabaseService();
    var textMessage = TextMessage(Uuid().v4(), FirebaseAuth.instance.currentUser!.uid, 'kEurpmVqwfe7giyZC1PQfPSNZSW2', '', 'TEXT', '');
    var imageMessage = ImageMessage(Uuid().v4(), FirebaseAuth.instance.currentUser!.uid, 'kEurpmVqwfe7giyZC1PQfPSNZSW2', '', 'IMAGE', '');

    Future pickImage() async{
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage ==null) return;

      imageMessage.image = pickedImage.path;
      await dbService.sendImageMessage(imageMessage);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Username'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GroupedListView<MessageDetailsList, DateTime>(
              padding: const EdgeInsets.all(8),
              reverse: true,
              order: GroupedListOrder.DESC,
              useStickyGroupSeparators: true,
              floatingHeader: true,
              elements: messages,
              groupBy: (message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              groupHeaderBuilder: (MessageDetailsList message) => SizedBox(
                  height: 40,
                  child: Center(
                      child: Card(
                          color:Theme.of(context).primaryColor,
                          child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                DateFormat.yMMMd().format(message.date),
                                style: const TextStyle(color: Colors.white),
                              )
                          )
                      )
                  )
              ),
              itemBuilder: (context, MessageDetailsList message) => Align(
                alignment: message.isSentByMe
                    ? Alignment.centerRight
                    : Alignment .centerLeft,
                child: Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(message.text),
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

                final message= MessageDetailsList
                  (text: text,
                    date: DateTime.now(),
                    isSentByMe: true);
                setState(()=> messages.add(message));
              },
            ),
          ),
        ],
      ),
    );
  }
}
