import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:toy_trader/screens/ToyDetailsScreen.dart';
import 'package:toy_trader/widgets/ToyGridList.dart';
import '../firebase_services/DatabaseService.dart';
import '../models/AppColors.dart';
import '../models/ProfileInfo.dart';
import '../models/Toy.dart';
import '../models/Trade.dart';
import 'ToyOfferList.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ToyBox extends StatefulWidget {
  final Toy toy;
  final int left;
  final ProfileInfo? user;
  final VoidCallback onClick;
  const ToyBox ({Key? key, required this.toy, required this.left,required this.user, required this.onClick,}): super(key:key);


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
    Radius boxCurve    = const Radius.circular(15);

    if(widget.left == 0){
      topInset =  deviceHeight(context) * .01;
      leftInset = deviceWidth(context) * .01;
      rightInset =   deviceWidth(context) * .010;
    }

    else{
      topInset =  deviceHeight(context) * .01;
      leftInset = deviceWidth(context) * .010;
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
                  decoration:  BoxDecoration(
                    color: AppColors.celadonBlue,
                    borderRadius: BorderRadius.all(boxCurve),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(200),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(boxCurve),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.toy.toyImageURL)
                        )
                    )
                ),

                if(widget.toy.ownerId == widget.user?.uid)
                  userMenu(dbS, widget.toy)
                else
                  searchMenu(dbS, widget.toy),

                Container(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      children: [
                        Text(
                        toyName,
                        style: const TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.w500,fontFamily: 'OpenSans'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ).frosted(
                          blur: 2,
                          frostColor: Colors.black,
                          borderRadius: BorderRadius.all(boxCurve),
                          height: 45,
                          width: 200,
                        )]
                    )
                      ),

              ],
            ),
            onTap:(){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ToyDetailsScreen(toy: widget.toy))
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
                widget.onClick();
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

  Widget searchMenu(DatabaseService dbS, Toy toy){
    return Container(
      alignment: Alignment.topRight,
      child: PopupMenuButton<toyMenu>(
        // Callback that sets the selected popup menu item.
          icon: const Icon(Icons.more_vert,color: Colors.black),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),

          onSelected: (toyMenu item) async {
            switch(item){
              case toyMenu.message:
                print("message owner");
                /*
                  Code to message owner of toy goes here
                */
                break;
              case toyMenu.offer:
                Trade tradeOffer;
                var userToys = await dbS.getUserToys("");
                var receiverToys = await dbS.getUserToys(toy.ownerId);

                int userTest = userToys.length;
                int receiverTest = receiverToys.length;

                await selectToysToTrade(userToys, receiverToys, context);

                if (userTest != userToys.length && receiverTest != receiverToys.length) {
                  ProfileInfo profileInfo = await DatabaseService().getProfileInfo(FirebaseAuth.instance.currentUser!.uid);
                  ProfileInfo otherProfileInfo = await DatabaseService().getProfileInfo(receiverToys[0].ownerId);
                  tradeOffer = Trade(
                      Uuid().v4(),
                      profileInfo.uid,
                      profileInfo.screenName,
                      otherProfileInfo.uid,
                      otherProfileInfo.screenName,
                      otherProfileInfo.profileImageUrl,
                      userToys,
                      receiverToys,
                      'Pending',
                      DateTime.now().toString()
                  );

                  DatabaseService().sendTradeOffer(tradeOffer);
                }

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
            const PopupMenuItem(
              value: toyMenu.offer,
              child: Text('Offer Trade'),
            ),
          ]),
    );
  }

  Future<void> selectToysToTrade(List<Toy> userToys, List<Toy> recieverToys, BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ToyOfferList(
          userToys, recieverToys)),
    );
  }

}
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
enum profileMenu { edit, delete }
enum toyMenu { message, offer }

