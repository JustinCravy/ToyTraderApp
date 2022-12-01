import 'package:flutter/material.dart';
import 'package:toy_trader/models/Toy.dart';
import 'package:toy_trader/widgets/MessageList.dart';
import 'package:toy_trader/widgets/ToyGridList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_services/DatabaseService.dart';
import '../models/ProfileInfo.dart';
import 'HomeScreen.dart';
import 'TradeHistoryScreen.dart';

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({Key? key}) : super(key: key);

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            )
        ),
        body: Container(child: MessageList()));
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
}

class ProfileScreen extends StatefulWidget {
  final String userId;
  const ProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DatabaseService dbService = DatabaseService();
  late ProfileInfo userProfile;

  @override
  Widget build(BuildContext context) {
    ProfileInfo userProfile;
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },

          )
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
        alignment: Alignment.topCenter,
        child: FutureBuilder<ProfileInfo?>(
          future: dbService.getProfileInfo(widget.userId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              userProfile = snapshot.data!;
              return Column(
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
                              image:
                                  NetworkImage(userProfile.profileImageUrl)))),
                  Container(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Text('Name: ' + userProfile.screenName,
                          style: const TextStyle(fontSize: 20))),
                  Container(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: const Text(
                        'Toys',
                        style: TextStyle(fontSize: 30),
                      )),
                  Flexible(
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          decoration: const BoxDecoration(
                              /*border: Border.all(
                            color: Colors.blue,
                            width: 2,
                          ),

                           */
                              ),
                          child: ToyGridList(userProfile.toys)))
                ],

              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          )
      ),
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
              height: deviceHeight(context) * .66,
              alignment: Alignment.topLeft,
              child: FutureBuilder<List<Toy>>(
                future: dbService.getMainFeed(myController.text),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Toy> toyList = snapshot.data!;

                    return Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Flexible(child: ToyGridList(toyList),)
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
