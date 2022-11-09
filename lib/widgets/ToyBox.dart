import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:toy_trader/screens/ToyDetailsScreen.dart';
import 'package:toy_trader/screens/BottomNavBar.dart';
import 'package:toy_trader/widgets/ToyGridList.dart';

import '../firebase_services/DatabaseService.dart';
import '../models/ProfileInfo.dart';
import '../models/Toy.dart';

class ToyBox extends StatefulWidget {
  final Toy toy;
  final int left;
  final ProfileInfo? user;

  const ToyBox ({Key? key, required this.toy, required this.left, required this.user}): super(key:key);


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
                      padding: const EdgeInsets.all(200),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 6, color: Colors.greenAccent),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(widget.toy.toyImageURL)
                          )
                      )
                  ),

                  if(widget.toy.ownerId == widget.user?.uid)
                    userMenu(dbS, widget.toy)
                  else
                    searchMenu(),

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

  Widget userMenu(dbS, toy){
    return Container(
      alignment: Alignment.topRight,
      child: PopupMenuButton<profileMenu>(
        // Callback that sets the selected popup menu item.
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),

          onSelected: (profileMenu item) {
            switch(item){
              case profileMenu.edit:
                print("edit Selected");
                break;
              case profileMenu.delete:
                dbS.deleteToy(toy);
                break;
              default:
                break;
            }
          },


          itemBuilder: (BuildContext context) => <PopupMenuEntry<profileMenu>>[
            const PopupMenuItem<profileMenu>(
              value: profileMenu.edit,
              child: Text('Edit'),
            ),
            const PopupMenuItem<profileMenu>(
              value: profileMenu.delete,
              child: Text('Delete'),
            ),
          ]),
    );
  }

  Widget searchMenu(){
    return Container(
      alignment: Alignment.topRight,
      child: PopupMenuButton<toyMenu>(
        // Callback that sets the selected popup menu item.
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),

          onSelected: (toyMenu item) {
            switch(item){
              case toyMenu.message:
                print("message owner");
                /*
                                 Code to message owner of toy goes here
                                 */
                break;
              case toyMenu.offer:


                break;
              default:
                break;
            }
          },

          itemBuilder: (BuildContext context) => <PopupMenuEntry<toyMenu>>[
            const PopupMenuItem<toyMenu>(
              value: toyMenu.message,
              child: Text('Message'),
            ),
            const PopupMenuItem<toyMenu>(
              value: toyMenu.offer,
              child: Text('Offer Trade'),
            ),
          ]),
    );
  }


}
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
enum profileMenu { edit, delete }
enum toyMenu { message, offer }

