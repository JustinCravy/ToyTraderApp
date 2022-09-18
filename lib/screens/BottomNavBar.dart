import 'package:flutter/material.dart';

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

               SizedBox(height: 20.0),
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


