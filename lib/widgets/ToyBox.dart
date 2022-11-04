import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:toy_trader/screens/ToyDetailsScreen.dart';


import '../firebase_services/DatabaseService.dart';
import '../models/Toy.dart';



class ToyBox extends StatefulWidget {

  @override
  State<ToyBox> createState() => _ToyBoxState();

}

class _ToyBoxState extends State<ToyBox> {
  @override
    Widget build(BuildContext context) {
      DatabaseService dbS = DatabaseService();
      String _selectedMenu = '';
      List<Toy> toyList = dbS.getToyList();

      return Container(
        padding: EdgeInsets.only(
          top: deviceHeight(context) * .04,
          right: deviceWidth(context) * .02,
          left: deviceWidth(context) * .02,
        ),
        child: InkWell(
             child: Container(
                width: deviceWidth(context) * .40,
                height: deviceWidth(context) * .50,
                decoration: const BoxDecoration(
                  color: Colors.greenAccent,
                ),
               child:Container(
                 alignment: Alignment.topRight,
                 child: PopupMenuButton<Menu>(
                   // Callback that sets the selected popup menu item.
                     color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                      ),
                     onSelected: (Menu item) {
                       switch(item){
                         case Menu.edit:
                           print("edit Selected");
                           /*
                           Code to go to the edit Toy Screen such as editing the contents of toy
                            */


                           break;
                         case Menu.delete:
                           dbS.deleteToy(toyList[0]);
                           print("The Toybox thinks there are $toyList.length toys");
                           break;
                           default:
                           break;
                       }
                     },
                     itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                       const PopupMenuItem<Menu>(
                         value: Menu.edit,
                         child: Text('Edit'),
                       ),
                       const PopupMenuItem<Menu>(
                         value: Menu.delete,
                         child: Text('Delete'),
                       ),
                     ]),
               ),
             ),

            onTap:(){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ToyDetailsScreen())
              );
             }
            )
        );
    }


  }
  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  enum Menu { edit, delete }