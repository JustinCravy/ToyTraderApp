import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:toy_trader/screens/ToyDetailsScreen.dart';
import 'package:toy_trader/screens/BottomNavBar.dart';
import 'package:toy_trader/widgets/ToyGridList.dart';

import '../firebase_services/DatabaseService.dart';
import '../models/Toy.dart';

class ToyBox extends StatefulWidget {
  final Toy toy;
  final int left;

  const ToyBox ({Key? key, required this.toy, required this.left}): super(key:key);


  @override
  State<ToyBox> createState() => _ToyBoxState();

}

class _ToyBoxState extends State<ToyBox> {
  @override
    Widget build(BuildContext context) {
      double leftInset;
      double rightInset;
      double topInset;

      String toyName  = widget.toy.name;
      DatabaseService dbS = DatabaseService();
      String _selectedMenu = '';
      List<Toy> toyList = dbS.getToyList();

      if(widget.left == 0){
        topInset =  deviceHeight(context) * .02;
        leftInset = deviceWidth(context) * .01;
        rightInset =   deviceWidth(context) * .015;
    }
      else{
        topInset =  deviceHeight(context) * .02;
        leftInset = deviceWidth(context) * .015;
        rightInset =   deviceWidth(context) * .01;
      }

      return Container(
        padding: EdgeInsets.only(
          top: topInset,
          right: rightInset,
          left: leftInset,
        ),
        child: InkWell(
             child:Stack(
               children: [

                 //replace with the Image of the toy
                 Container(
                    decoration: const BoxDecoration(
                    color: Colors.greenAccent,
                      ),
                 ),
                  Container(
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
                                case Menu.delete:/*
                                 Code to go to delete toys goes here
                                 */
                                  dbS.deleteToy(widget.toy);
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

                 Container(
                     alignment: Alignment.bottomCenter,
                   padding: EdgeInsets.only(
                       bottom: deviceHeight(context) * .01,
                   ),
                     child: Text(
                                toyName,
                                style: const TextStyle(fontSize: 20, color: Colors.black54),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                            )
                 ),

               ],
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