import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:toy_trader/screens/ToyDetailsScreen.dart';

class ToyBox extends StatefulWidget {
  @override
  State<ToyBox> createState() => _ToyBoxState();

}

class _ToyBoxState extends State<ToyBox> {
  String _selectedMenu = '';

  @override
    Widget build(BuildContext context) {
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
                           /*Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) => ())
                           );

                            */
                           break;
                         case Menu.delete:

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
                         child: Text('Delete11  11'),
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