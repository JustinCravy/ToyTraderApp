import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:toy_trader/models/AppColors.dart';
import 'package:toy_trader/models/Toy.dart';
import 'package:toy_trader/screens/BottomNavBar.dart';
import 'package:toy_trader/widgets/MessageDetailsBox.dart';
import 'package:toy_trader/widgets/MyBehavior.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_services/DatabaseService.dart';
import '../models/ProfileInfo.dart';
import 'HomeScreen.dart';
import 'TradeHistoryScreen.dart';

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
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'Trade History', 'Logout'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
            title: IconButton(
              color: Colors.white,
              iconSize: physicalHeight / 11,
              icon: Image.asset('assets/images/logo.png'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            )
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
          Divider(thickness: 3, color: AppColors.richBlack),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: SizedBox(height: deviceHeight(context) * .045),
                ), TextSpan(
                    text: "Quality             ",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: AppColors.richBlack,
                        fontWeight: FontWeight.w500)),
                TextSpan(
                    text: "${toy.condition}\n",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: AppColors.celadonBlue,
                        fontWeight: FontWeight.w500)),
                WidgetSpan(
                  child: SizedBox(height: deviceHeight(context) * .045),
                ),
                TextSpan(
                    text: "Ages                 ",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: AppColors.richBlack,
                        fontWeight: FontWeight.w500)),
                TextSpan(
                    text: "${toy.ageRange}\n",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: AppColors.celadonBlue,
                        fontWeight: FontWeight.w500)),
                WidgetSpan(
                  child: SizedBox(height: deviceHeight(context) * .045),
                ),
                TextSpan(
                    text: "Category          ",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: AppColors.richBlack,
                        fontWeight: FontWeight.w500)),
                TextSpan(
                    text: "${toy.categories}",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: AppColors.celadonBlue,
                        fontWeight: FontWeight.w500,
                      fontFamily: 'OpenSans'
                    )
                ),])),
          SizedBox(height: deviceHeight(context) * .025),
          Divider(thickness: 3, color: AppColors.richBlack),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Text(
              "Description",
              style: TextStyle(
                  fontSize: 22,
                  color: AppColors.richBlack,
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
                  fontSize: 20.0,
                  color: AppColors.celadonBlue,
                  fontWeight: FontWeight.w400,
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
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColors.prussianBlue,
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
            decoration:  BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColors.prussianBlue,
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

  void handleClick(String value) async {
    switch (value) {
      case 'Logout':
        await FirebaseAuth.instance.signOut();
        break;
      case 'Trade History':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TradeHistory()),
        );
        break;
    }
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
