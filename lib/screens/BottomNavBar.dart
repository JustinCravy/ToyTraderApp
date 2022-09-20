import 'package:flutter/material.dart';
import 'package:toy_trader/widgets/MessageList.dart';
import 'package:toy_trader/widgets/ToyBox.dart';
import 'package:toy_trader/widgets/ToyGridList.dart';

import 'AddToyScreen.dart';
import 'MainScreen.dart';
import 'MessageTabScreen.dart';

class MessagesScreen extends StatelessWidget{
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: const Color(0xffC4DFCB),
         child: MessageTabScreen(),
      ),
    );
  }
}


class MainScreen extends StatelessWidget{
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: const Color(0xffC4DFCB),
        child: MainHomeScreen(),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: const Color(0xffC4DFCB),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 Padding(
                  padding : EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(

                    decoration: InputDecoration(

                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {

                        }//Need to be linked with search result
                      ),
                        hintText: 'Search your toys',
                      border: OutlineInputBorder()
                    ),
                  )
                ),

               Container(
                 width: deviceWidth(context),
                 height: deviceHeight(context) *.58,
                 alignment: Alignment.topLeft,
                 child: ToyGridList(),
               ),

               SizedBox(height: 0.0),
                RaisedButton(
                    child: const Text('To Add Toys'),
                    onPressed: ()  {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddToyScreen()));
                    }
                ),


              ],
            )

        ),
      ),
    );
  }
}

//longlist, need to get data from data base and covert
//into widget data type
//will be moved into SearchToyScreen and rebuild framework.
List<String> getList(){
  var items=List<String>.generate(10,(counter)=>"Toy $counter");
  return items;
}

Widget getListView(){
  var listitems = getList();
  var listView = ListView.builder(
      itemBuilder:(context, index){
        return ListTile(
          title: Text(listitems[index])
        );
      }
  );
  return listView;
}
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;


