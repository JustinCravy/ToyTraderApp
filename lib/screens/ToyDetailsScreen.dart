import 'dart:ui';

import 'package:flutter/material.dart';

class ToyDetailsScreen extends StatelessWidget{
  const ToyDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Row(
        children: <Widget>[
          Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text("Toy Name: Nerf Gun", style: new TextStyle(fontSize: 25.0)),
                  new Text("Quality: Excellent", style: new TextStyle(fontSize: 25.0)),
                  new Text("Seller: James Smith", style: new TextStyle(fontSize: 25.0)),
                  new Text("Location: Sacramento, CA", style: new TextStyle(fontSize: 25.0)),
                  new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Image.asset('assets/images/greenbutton.png',width:250,height:200),
                      new Image.asset('assets/images/redbutton.png',)
                    ],
                  )
                ],
              )
          ),
        ]
    );

    return Scaffold(
      // backgroundColor: const Color(0xffC4DFCB),
        appBar: AppBar(
          title: const Text(
            "Toy Trader",
            style: TextStyle(
              // color: Theme.of(context).primaryColor,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          // centerTitle: true,
          // backgroundColor: Colors.white,
        ),

        body: new ListView(
            children: <Widget>[
              new Image.asset(
                'assets/images/nerfgun1.jpg',
              ),
              titleSection,
            ]
        )
    );
  }
}