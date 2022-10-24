import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../firebase_services/DatabaseService.dart';
import '../models/Toy.dart';
import 'ToyBox.dart';


class ToyGridList extends StatefulWidget {


  @override
  _ToyGridListState createState() => _ToyGridListState();


}


class  _ToyGridListState extends State<ToyGridList> {
  int _counter = 0;

  void _incrementCounter(){
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseService dbS = DatabaseService();
    List<Toy> toyList = dbS.getToyList();
    List<Widget> widgetList = [];


    if(toyList.isEmpty){
      return showEmptyWidgets();
    }
    else{
      for (var i = 0; i < toyList.length; i++) {
        widgetList.add(ToyBox()
        );
      }

      return showPopulatedList(widgetList);
    }


  }

  Stack showEmptyWidgets() {
    return Stack(
      children: [
        Container(

          child: Text("You have no Toys"),
        ),
        MaterialButton(
          onPressed: () {},
          color: Colors.blue,
          textColor: Colors.white,
          child: Icon(
            Icons.add,
            size: 114,
          ),
          padding: EdgeInsets.all(0),
          shape: CircleBorder(),
        )
      ],


    );

  }

  Stack showPopulatedList(List<Widget> widgetList) {
    return Stack(
      children: [
        Container(

          child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: widgetList
          ),
        ),
       Padding(
        padding: EdgeInsets.all(10),
       child: Align(

          alignment: Alignment.bottomRight,
        child: MaterialButton(
          onPressed: () {},
          color: Colors.blue,
          textColor: Colors.white,
          child: Icon(
            Icons.add,
            size: 30,
          ),
          padding: EdgeInsets.all(5),
          shape: CircleBorder(),

        )
        )
       )
      ],


    );
  }



}



