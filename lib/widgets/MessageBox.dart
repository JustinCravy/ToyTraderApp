import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:toy_trader/screens/MessageDetailsBox.dart';


class MessageBox extends StatefulWidget {
  @override
  State<MessageBox> createState() => _MessageBoxState();

}

class _MessageBoxState extends State<MessageBox>{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: deviceHeight(context) * .04,
        right: deviceWidth(context) *.02,
        left: deviceWidth(context) *.02,
      ),
      child: InkWell(

          //
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:  <Widget>[
             /* const Icon(
                    Icons.person,
                    color: Colors.lightBlue,
                    size: 48.0,
                  ),

              */
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
             Container(
                 width: deviceWidth(context) * .75,
                 height:  deviceWidth(context) * .2,
               decoration: const BoxDecoration(
                 color: Colors.black12,
                 borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(15),
                   topRight: Radius.circular(15),
                   bottomRight: Radius.circular(15),
                 )
               ),
               child:Expanded(
                 child: Padding(
                 padding: EdgeInsets.only(
                   left: deviceWidth(context) *.05,
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: const [
                     SizedBox(height: 10),
                     Text(
                         'Username',style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
                         textAlign: TextAlign.left),
                     SizedBox(height: 10),
                     Text('This will be the last message sent from another user if the message is too long is should cut off',
                       style: TextStyle(fontSize: 14,color: Colors.black, fontWeight: FontWeight.w400),
                       textAlign: TextAlign.left,
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,

                     )
                 ],
               ),
                 )
               )
             )
            ],
          ),

          //When pressed will be sent to the message details screen
          onTap:(){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MessageDetailsBox())
            );
          }
      ),
    );
  }
  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
}

