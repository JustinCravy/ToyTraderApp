import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toy_trader/models/ProfileInfo.dart';
import 'package:provider/provider.dart';
import '../firebase_services/AuthService.dart';
import '../firebase_services/DatabaseService.dart';
import '../models/Toy.dart';
import '../screens/AddToyScreen.dart';
import 'ToyBox.dart';

class ToyGridList extends StatefulWidget {
  final List<Toy> toyList;

  const ToyGridList(this.toyList, {super.key});

  @override
  _ToyGridListState createState() => _ToyGridListState();
}

class _ToyGridListState extends State<ToyGridList> {
  AuthService authService = AuthService();
  DatabaseService dbS = DatabaseService();


  @override
  Widget build(BuildContext context) {
    List<Toy> toyList = widget.toyList;
    List<Widget> widgetList = [];

    ProfileInfo? user = Provider.of<ProfileInfo?>(context);

    if (toyList.isEmpty) {
      return showEmptyWidgets(dbS, user);
    } else {
      for (var i = 0; i < toyList.length; i++) {
        widgetList.add(ToyBox(
            toy: toyList[i],
            left: i % 2,
            user: user
        ));
      }

      return showPopulatedList(widgetList, dbS, user);
    }
  }

  Stack showEmptyWidgets(dbS, user) {
    return Stack(
      children: [
        Container(
          child: Text(
            "You have no Toys",
          ),
        ),
        Padding(
            padding: EdgeInsets.all(10),
            child: Align(
                alignment: Alignment.bottomRight,
                child: MaterialButton(
                  onPressed: () async {
                    user = await dbS.getProfileInfo(user!.uid);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddToyScreen(profileInfo: user,)));
                  },
                  color: Colors.lightGreenAccent,
                  textColor: Colors.white,
                  child: const Icon(
                    Icons.add,
                    size: 30,
                  ),
                  padding: EdgeInsets.all(5),
                  shape: CircleBorder(),
                )))
      ],
    );
  }

  Stack showPopulatedList(List<Widget> widgetList, dbS, user) {
    return Stack(
      children: [
        Container(
          child: GridView.count(
              shrinkWrap: true, crossAxisCount: 2, children: widgetList),
        ),
        Padding(
            padding: EdgeInsets.all(10),
            child: Align(
                alignment: Alignment.bottomRight,
                child: MaterialButton(
                  onPressed: () async {
                    user = await dbS.getProfileInfo(user!.uid);
                    Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context) => AddToyScreen(profileInfo: user,)
                    )
                    );
                  },
                  color: Colors.lightGreenAccent,
                  textColor: Colors.white,
                  child: const Icon(
                    Icons.add,
                    size: 30,
                  ),
                  padding: EdgeInsets.all(5),
                  shape: CircleBorder(),
                )))
      ],
    );
  }
}

