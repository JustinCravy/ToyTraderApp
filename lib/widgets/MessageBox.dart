import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:toy_trader/widgets/MessageDetailsBox.dart';

import '../models/AppColors.dart';
import '../models/Conversation.dart';


class MessageBox extends StatefulWidget {
  final Conversation convo;


  const MessageBox({Key? key, required this.convo}) : super(key: key);

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {

  @override
  Widget build(BuildContext context) {
    String lastMessage = widget.convo.lastMessage;
    String time        = widget.convo.time;
    String name        = widget.convo.otherScreenName;
    String profileImg  = widget.convo.otherProfileImgUrl;

    double height      = deviceHeight(context) * .13; //controls height of message box
    Radius boxCurve    = const Radius.circular(15);


    var displayTime = getTimeDifference(time);

    return Container(
      //Sets the height and width of the Row With will be locked to list while
      height: height,
      width: double.infinity,

      //Creates the Padding around the MessageBox
      // Bottom padding doesn't need to be specified since it is controlled by ListView
      padding: EdgeInsets.only(
        top: deviceHeight(context) * .04,
        right: deviceWidth(context) * .03,
        left: deviceWidth(context) * .02,
      ),

        // Creates a Row of Widgets on the
        // left will be Profile and the right is the Messages
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly, //sets how the widgets are aligned in the row

          children: <Widget>[

            //Creates an Inkwell so that the profile Image can be clickable.
             InkWell(
               //customBorder: const CircleBorder(),
               child:  CircleAvatar(
                 backgroundImage: NetworkImage(profileImg),
                 radius: 25,
               ),

              onTap: (){},
            ),

            //Wraps the message in an Inkwell that will send the user to the MessageDetailsScreen.
            InkWell(

              //Creates the Message Box with the grey background
              //width will be based on deviceWidth
              //Height is based off of The height of
                    child: Container(
                    width: deviceWidth(context) * .75,
                    height: height,
                    decoration: BoxDecoration(
                        color: AppColors.celadonBlue,
                        borderRadius: BorderRadius.only(
                          topLeft: boxCurve,
                          topRight: boxCurve,
                          bottomRight: boxCurve,
                          bottomLeft: boxCurve
                        )),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: deviceWidth(context) * .045,
                      ),

                      ///Creates a column to Display the text within the Message Box
                      ///[SizedBox] widgets are placed in the Column to add spacing
                      ///First text is Username Second Text is Last Message.
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 10),
                           Text(name,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left),
                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: deviceWidth(context) * .45,
                                child: Text(
                                  lastMessage,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400
                                  ),
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.only(right: (deviceWidth(context) * .045)),
                                  child: Text(
                                    displayTime,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.right,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                ),
                              )
                              )
                            ],
                          )
                        ],
                      ),
                    )
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MessageDetailsBox(otherUserId: widget.convo.otherUserId,)));
                }
                ),
          ],),
    );
  }

  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  getTimeDifference(String time) {
    DateTime received  = DateTime.parse(time);
    DateTime now       = DateTime.now();

    var timeDiffDays = now.difference(received).inDays;
    var timeDiffHours = now.difference(received).inHours;
    var timeDiffMinutes = now.difference(received).inMinutes;
    var timeDiffSeconds = now.difference(received).inSeconds;

    if(timeDiffDays > 0){
      return "$timeDiffDays days ago";
    }
    else if(timeDiffMinutes > 59){
      return "$timeDiffHours hours ago";
    }
    else if(timeDiffMinutes > 0){
      return "$timeDiffMinutes min ago";
    }else{
      return "$timeDiffSeconds sec ago";
    }


  }
}
