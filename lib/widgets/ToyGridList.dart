import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toy_trader/models/AppColors.dart';
import 'package:toy_trader/models/ProfileInfo.dart';
import 'package:provider/provider.dart';
import 'package:toy_trader/screens/HomeScreen.dart';
import '../firebase_services/AuthService.dart';
import '../firebase_services/DatabaseService.dart';
import '../models/Toy.dart';
import '../screens/AddToyScreen.dart';
import 'ToyBox.dart';

class ToyGridList extends StatefulWidget {
  final List<Toy> toyList;

  const ToyGridList(this.toyList, {super.key,});

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
            user: user, onClick: () {setState(() {
              toyList.removeAt(i);
            });},
        ));
      }

      return showPopulatedList(widgetList, dbS, user);
    }
  }

  Stack showEmptyWidgets(dbS, user) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Container(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Icon(
                        Icons.thunderstorm,
                        color: Colors.black,
                        size: physicalScreenSize.width / 8
                    ),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  ),
                  const Text('There are no toys to display!',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'assets/fonts/YanoneKaffeesatz-Regular.ttf'
                    ),
                  )
                ],
              )
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
                  color: Colors.blue,
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
              shrinkWrap: true, crossAxisCount: 2, children: [...widgetList]),
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
                  color: AppColors.carolinaBlue,
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

