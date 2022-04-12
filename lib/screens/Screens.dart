import 'package:flutter/material.dart';


class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Messages",
          style: TextStyle(
            color: Colors.blue[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget{
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Home",
          style: TextStyle(
            color: Colors.blue[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class SearchToysScreen extends StatelessWidget{
  const SearchToysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Search toys",
          style: TextStyle(
            color: Colors.blue[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

