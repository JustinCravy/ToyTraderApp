import 'package:flutter/material.dart';

import 'MainScreen.dart';
import 'MessageDetailsScreen.dart';
import 'MessageTabScreen.dart';
import 'ToyDetailsScreen.dart';

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

class SearchToysScreen extends StatelessWidget{
  const SearchToysScreen({Key? key}) : super(key: key);

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
                )

               /* SizedBox(height: 20.0),
                RaisedButton(
                    child: const Text('To Toy Details'),
                    onPressed: ()  {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ToyDetailsScreen()));
                    }
                ),*/
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


