import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toy_trader/models/Toy.dart';

class ToyDetailsScreen extends StatelessWidget {
  final Toy toy;

  const ToyDetailsScreen({Key? key, required this.toy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = toy.name;
    String quality = toy.condition;
    String toyImg = toy.toyImageURL;

    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 0,

            ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(toy.name, style: const TextStyle(fontSize: 25.0) , textAlign: TextAlign.center),
          ),
          Container(
              height: 300,
              width: 100,
              margin: EdgeInsets.only(),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      fit: BoxFit.fill, image: NetworkImage(toy.toyImageURL)))),
          toyInteractions(context),
          titleSection(),
        ]));
  }

  Widget titleSection() {
    return Row(
        children: [
      Expanded(
          child: Column(
            children: [
              Text("Quality: " + toy.condition,
                  style: new TextStyle(fontSize: 20.0)),
              Text(toy.description, style: new TextStyle(fontSize: 20.0)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
              )
            ],
          )),
    ]);
  }

  toyInteractions(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            height: deviceHeight(context) * .07,
            width: deviceWidth(context) * .40,
            decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
              child: Center(child: Text("Message", style: new TextStyle(fontSize: 25.0,color: Colors.white),
                textAlign: TextAlign.center,)),

          ),
        ),
        InkWell(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            height: deviceHeight(context) * .07,
            width: deviceWidth(context) * .40,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.blueAccent,
              borderRadius: BorderRadius.all(Radius.circular(30)),

            ),
            child: Center(child: Text("Trade", style: new TextStyle(fontSize: 25.0,color: Colors.white),
                                               textAlign: TextAlign.center,)),
          ),)
      ],
    );
  }
  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
}
