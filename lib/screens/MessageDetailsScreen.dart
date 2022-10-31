import 'package:flutter/material.dart';

class MessageDetailsScreen extends StatelessWidget{
  const MessageDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        // color: const Color(0xffC4DFCB),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding : EdgeInsets.symmetric(horizontal: 8, vertical: 16),

                    child: TextField(

                      decoration: InputDecoration(

                          suffixIcon: IconButton(
                              icon: Icon(Icons.send),

                              // TODO: button needs to be setup to send message
                              onPressed: () {

                              }
                          ),
                          hintText: 'Enter message here',
                          border: OutlineInputBorder()
                      ),
                    )
                )
              ],
            )
        ),
      ),
    );
  }
}
