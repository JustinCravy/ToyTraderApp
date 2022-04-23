import 'package:flutter/material.dart';

import 'MessageDetailsScreen.dart';
import 'MessageTabScreen.dart';
import 'ToyDetailsScreen.dart';

class MessagesScreen extends StatelessWidget{
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: const Color(0xffC4DFCB),
         child: MessageTabScreen(),
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
    return Scaffold(
      body: Container(
        // color: const Color(0xffC4DFCB),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Search Toys Screen",
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 20.0),
                RaisedButton(
                    child: const Text('To Toy Details'),
                    onPressed: ()  {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ToyDetailsScreen()));
                    }
                ),
              ],
            )
        ),
      ),
    );
  }
}


