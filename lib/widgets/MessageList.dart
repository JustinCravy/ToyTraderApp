import 'package:flutter/cupertino.dart';

import 'MessageBox.dart';

class MessageList extends StatelessWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children:  [
          MessageBox(),
          MessageBox(),
          MessageBox(),
          MessageBox(),
          MessageBox(),
          MessageBox(),
        ]
    );
  }
}