import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:toy_trader/models/Toy.dart';
import 'package:toy_trader/screens/EditProfileScreen.dart';
import 'package:toy_trader/widgets/MessageList.dart';
import 'package:toy_trader/widgets/ToyGridList.dart';

import '../firebase_services/DatabaseService.dart';
import '../models/ProfileInfo.dart';
import 'HomeScreen.dart';
import 'TradeHistoryScreen.dart';
import 'authentication/SignInScreen.dart';

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({Key? key}) : super(key: key);

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // backgroundColor: const Color(0xffC4DFCB),
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
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            )),
        body: Container(child: MessageList()));
  }

  void handleClick(String value) async {
    switch (value) {
      case 'Logout':
        await FirebaseAuth.instance.signOut();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignInScreen(
                    toggleView: toggleView,
                  )),
        );
        break;
      case 'Trade History':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TradeHistory()),
        );
        break;
    }
  }
}

class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DatabaseService dbService = DatabaseService();
  ProfileInfo? otherUserProfile;
  ProfileInfo? myProfileInfo;
  bool showSignIn = true;
  Widget _body = const Center(child: CircularProgressIndicator());

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  void initState() {
    getProfileInfo_setStateWhenDone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            )),
        body: _body);
  }

  void handleClick(String value) async {
    switch (value) {
      case 'Logout':
        await FirebaseAuth.instance.signOut();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignInScreen(
                    toggleView: toggleView,
                  )),
        );
        break;
      case 'Trade History':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TradeHistory()),
        );
        break;
    }
  }

  void getProfileInfo_setStateWhenDone() async {
    otherUserProfile = await DatabaseService().getProfileInfo(widget.userId);
    await DatabaseService()
        .getProfileInfo(FirebaseAuth.instance.currentUser!.uid)
        .then((value) {
      myProfileInfo = value;
      setState(() => _body = Stack(children: [
            Container(
                padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Container(
                        width: 120,
                        height: 120,
                        padding: const EdgeInsets.all(200),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 3, color: Colors.blue),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    otherUserProfile!.profileImageUrl)))),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                            visible:
                                (myProfileInfo!.uid != otherUserProfile!.uid),
                            child: TextButton.icon(
                              icon: Icon(
                                Icons.block,
                                color: Colors.red,
                              ),
                              label: Text(
                                (myProfileInfo!.blockedUsers
                                        .contains(otherUserProfile!.uid))
                                    ? 'Unblock User'
                                    : 'Block User',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () async {
                                print("blocking user");
                                if (!myProfileInfo!.blockedUsers
                                    .contains(otherUserProfile!.uid)) {
                                  await dbService.blockUser(
                                      myProfileInfo!, otherUserProfile!);
                                } else {
                                  await dbService.unblockUser(
                                      myProfileInfo!, otherUserProfile!);
                                }
                              },
                            )),
                        Visibility(
                            visible:
                                (myProfileInfo!.uid == otherUserProfile!.uid),
                            child: TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfileScreen()))
                                      .then((value) {
                                    setState(() {
                                      getProfileInfo_setStateWhenDone();
                                    });
                                  });
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                                label: Text('Edit Profile')))
                      ],
                    )),
                    Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: const Text(
                          'Toys',
                          style: TextStyle(fontSize: 30),
                        )),
                    Flexible(
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            decoration: const BoxDecoration(),
                            child: ToyGridList(otherUserProfile!.toys))),
                  ],
                )),
            Positioned(
              left: 5.0,
              top: 5.0,
              child: Text('Name: ' + otherUserProfile!.screenName,
                  style: const TextStyle(fontSize: 20)),
            ),
            Positioned(
                right: 4.0,
                top: 5.0,
                child: Container(
                    child: Row(children: [
                  RatingBar.builder(
                    initialRating: otherUserProfile!.userRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 25,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 1,
                    ),
                    onRatingUpdate: (double value) {},
                  ),
                  Text(
                    '(${otherUserProfile!.totalRates})',
                    style: TextStyle(fontSize: 20),
                  )
                ]))),
          ]));
    });
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DatabaseService dbService = DatabaseService();
  final myController = TextEditingController();
  String searchText = "";
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as ProfileInfo?;
    ProfileInfo? profileInfo;
    if (arg != null) {
      profileInfo = arg;
    }
    return Scaffold(
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
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          )),
      body: SingleChildScrollView(
        // color: const Color(0xffC4DFCB),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: myController,
                  onSubmitted: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            setState(() {});
                          } //Need to be linked with search result
                          ),
                      hintText: 'Search for toys',
                      border: OutlineInputBorder()),
                )),
            Container(
              width: deviceWidth(context),
              height: deviceHeight(context) * .80 - 85,
              alignment: Alignment.topLeft,
              child: FutureBuilder<List<Toy>?>(
                future: dbService.getMainFeed(myController.text),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Toy> toyList = snapshot.data!;

                    return Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Flexible(
                            child: ToyGridList(toyList),
                          )
                        ]);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleClick(String value) async {
    switch (value) {
      case 'Logout':
        await FirebaseAuth.instance.signOut();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignInScreen(
                    toggleView: toggleView,
                  )),
        );
        break;
      case 'Trade History':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TradeHistory()),
        );
        break;
    }
  }
}

//longlist, need to get data from data base and covert
//into widget data type
//will be moved into SearchToyScreen and rebuild framework.
List<String> getList() {
  var items = List<String>.generate(10, (counter) => "Toy $counter");
  return items;
}

Widget getListView() {
  var listitems = getList();
  var listView = ListView.builder(itemBuilder: (context, index) {
    return ListTile(title: Text(listitems[index]));
  });
  return listView;
}

double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
