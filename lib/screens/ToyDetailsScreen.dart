import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:toy_trader/models/Toy.dart';
import 'package:toy_trader/screens/BottomNavBar.dart';
import 'package:toy_trader/widgets/MessageDetailsBox.dart';
import 'package:toy_trader/widgets/MyBehavior.dart';

import '../firebase_services/DatabaseService.dart';
import '../models/ProfileInfo.dart';

class ToyDetailsScreen extends StatefulWidget {
  final Toy toy;

  const ToyDetailsScreen({Key? key, required this.toy}) : super(key: key);

  @override
  State<ToyDetailsScreen> createState() => _ToyDetailsScreenState();
}

class _ToyDetailsScreenState extends State<ToyDetailsScreen> {
  Widget _body = CircularProgressIndicator();
  ProfileInfo? ownerProfileInfo;

  @override
  void initState() {
    getOwnerProfileImg_setStateWhenDone(ownerProfileInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
        ),
        body: _body);
  }

  Widget titleSection(toy, context) {
    return Padding(
      padding: EdgeInsets.only(
          left: deviceWidth(context) * .05, right: deviceWidth(context) * .05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(thickness: 3, color: Colors.blueAccent),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: SizedBox(height: deviceHeight(context) * .045),
                ),
                const TextSpan(
                    text: "Quality             ",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500)),
                TextSpan(
                    text: "${toy.condition}\n",
                    style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500)),
                WidgetSpan(
                  child: SizedBox(height: deviceHeight(context) * .045),
                ),
                const TextSpan(
                    text: "Ages                 ",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500)),
                TextSpan(
                    text: "${toy.ageRange}\n",
                    style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500)),
                WidgetSpan(
                  child: SizedBox(height: deviceHeight(context) * .045),
                ),
                const TextSpan(
                    text: "Category          ",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500)),
                TextSpan(
                    text: "${toy.categories}\n",
                    style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500)),
                WidgetSpan(
                  child: SizedBox(height: deviceHeight(context) * .035),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 0),
            child: Text(
              "Description",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: deviceHeight(context) * .016),
          SingleChildScrollView(
            child: Container(
              child: ReadMoreText(
                "${toy.description}",
                trimLines: 3,
                textAlign: TextAlign.justify,
                trimMode: TrimMode.Line,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          SizedBox(height: deviceHeight(context) * .10)
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
                builder: (context) =>
                    MessageDetailsBox(otherUserId: widget.toy.ownerId),
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

  getOwnerProfileImg_setStateWhenDone(ProfileInfo? ownerProfileInfo) async {
    await DatabaseService().getProfileInfo(widget.toy.ownerId).then((value) {
      ownerProfileInfo = value;
      setState(() => _body = Stack(children: [
            ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView(children: [
                Container(
                    height: 300,
                    width: 100,
                    margin: const EdgeInsets.only(),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.toy.toyImageURL)))),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(widget.toy.name,
                      style: const TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'ComicSans',
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
                titleSection(widget.toy, context),
              ]),
            ),
            Positioned(
                left: 20.0,
                top: 20.0,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfileScreen(userId: widget.toy.ownerId),
                      ),
                    );
                  },
                    child: Container(
                        width: 60,
                        height: 60,
                        padding: const EdgeInsets.all(200),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 3, color: Colors.blue),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    ownerProfileInfo!.profileImageUrl)))))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: toyInteractions(context)),
            ),
          ]));
    });
  }

  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
}
