import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:toy_trader/models/Toy.dart';
import 'package:toy_trader/screens/MessageDetailsScreen.dart';
import 'package:toy_trader/widgets/MessageDetailsBox.dart';
import 'package:toy_trader/widgets/MyBehavior.dart';

class ToyDetailsScreen extends StatefulWidget {
  final Toy toy;

  const ToyDetailsScreen({Key? key, required this.toy}) : super(key: key);

  @override
  State<ToyDetailsScreen> createState() => _ToyDetailsScreenState();

}

class _ToyDetailsScreenState extends State<ToyDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Toy toy = widget.toy;

    String name = toy.name;
    String quality = toy.condition;
    String toyImg = toy.toyImageURL;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
        ),
        body: Stack(children: [
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView(

                children: [
              Container(
                  height: 300,
                  width: 100,
                  margin: const EdgeInsets.only(),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(toy.toyImageURL)))),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(toy.name,
                    style: const TextStyle(fontSize: 25.0, fontFamily: 'ComicSans', fontWeight: FontWeight.bold ),
                    textAlign: TextAlign.center),
              ),
              titleSection(toy, context),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: toyInteractions(context)),
          ),
        ]));
  }

  Widget titleSection(toy, context) {

    return Padding(
      padding:  EdgeInsets.only(left: deviceWidth(context) * .05, right: deviceWidth(context) * .05),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            const Divider(
                thickness: 3,
                color: Colors.blueAccent
            ),
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: SizedBox(height: deviceHeight(context)* .045 ),
                  ),
                  const TextSpan(
                    text: "Quality             ",
                    style: TextStyle(fontSize: 20.0, color: Colors.black87, fontWeight: FontWeight.w500)
                  ),
                  TextSpan(
                      text: "${toy.condition}\n",
                      style: const TextStyle(fontSize: 20.0, color: Colors.black54, fontWeight: FontWeight.w500)
                  ),
                   WidgetSpan(
                    child: SizedBox(height: deviceHeight(context)* .045 ),
                  ),
                  const TextSpan(
                      text: "Ages                 ",
                      style: TextStyle(fontSize: 20.0, color: Colors.black87, fontWeight: FontWeight.w500)
                  ),
                  TextSpan(
                      text: "${toy.ageRange}\n",
                      style: const TextStyle(fontSize: 20.0, color: Colors.black54, fontWeight: FontWeight.w500)
                  ),
                  WidgetSpan(
                    child: SizedBox(height: deviceHeight(context)* .045 ),
                  ),
                  const TextSpan(
                      text: "Category          ",
                      style: TextStyle(fontSize: 20.0, color: Colors.black87, fontWeight: FontWeight.w500)
                  ),
                  TextSpan(
                      text: "${toy.categories}\n",
                      style: const TextStyle(fontSize: 20.0, color: Colors.black54, fontWeight: FontWeight.w500)
                  ),
                  WidgetSpan(
                    child: SizedBox(height: deviceHeight(context)* .035 ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 0),
              child: Text(
                "Description",
                style: TextStyle(fontSize: 22, color: Colors.black87, fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              ),
            ),

            SizedBox( height: deviceHeight(context) * .016),
            SingleChildScrollView(
              child: Container(
                  child: ReadMoreText("${toy.description}", trimLines: 3,
                    textAlign: TextAlign.justify,
                    trimMode: TrimMode.Line,
                    style: TextStyle(fontSize: 16.0,),

                  ),
              ),
            ),
            SizedBox( height: deviceHeight(context) * .10)
          ],
      ),
    );
  }

  toyInteractions(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(45),
          child: Container(
            margin: EdgeInsets.only(top: 10),
            height: deviceHeight(context) * .07,
            width: deviceWidth(context) * .40,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.blueAccent,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Center(
                child: Text(
              "Message",
              style: new TextStyle(fontSize: 25.0, color: Colors.white),
              textAlign: TextAlign.center,
            )),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessageDetailsBox(otherUserId: widget.toy.ownerId),
              ),
            );
          },
        ),
        InkWell(
          borderRadius: BorderRadius.circular(45),
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            height: deviceHeight(context) * .07,
            width: deviceWidth(context) * .40,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.blueAccent,
              borderRadius: BorderRadius.all(Radius.circular(30)),

            ),
            child: Center(
                child: Text(
              "Trade",
              style: new TextStyle(fontSize: 25.0, color: Colors.white),
              textAlign: TextAlign.center,
            )),
          ),
        )
      ],
    );
  }

  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
}
