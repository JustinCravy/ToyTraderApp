import 'package:flutter/material.dart';
import 'package:toy_trader/models/Toy.dart';
import '../firebase_services/DatabaseService.dart';
import 'package:toy_trader/widgets/MessageList.dart';
import 'package:toy_trader/widgets/ToyGridList.dart';
import '../models/ProfileInfo.dart';
import 'AddToyScreen.dart';

class ConversationsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SingleChildScrollView(
              child: MessageList(),
            )
          ],
        ),
      ),
    );
  }
}



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DatabaseService dbService = DatabaseService();
  late ProfileInfo userProfile;

  @override
  Widget build(BuildContext context) {
    ProfileInfo userProfile;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
        alignment: Alignment.topCenter,
        child: FutureBuilder<ProfileInfo?>(
          future: dbService.getProfileInfo(""),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              userProfile = snapshot.data!;
              return Column(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    padding: const EdgeInsets.all(200),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 3, color: Colors.blue),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(userProfile.profileImageUrl)
                      )
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    alignment: Alignment.centerLeft,
                    child: Text('Name: ' + userProfile.screenName, style: const TextStyle(fontSize: 20))
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: const Text('Your Toys',
                    style: TextStyle(fontSize: 30),)
                  ),
                  Flexible(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            return const Text("Toy test");
                          },
                        itemCount: 6,
                      )
                    )
                  )
                ],
              );
            }
            else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}


class MainScreen extends StatelessWidget{
   MainScreen({Key? key}) : super(key: key);

   DatabaseService dbService = DatabaseService();


  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as ProfileInfo?;
    ProfileInfo? profileInfo;
    if(arg != null) {
      profileInfo = arg;
    }

    print(profileInfo);
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
                 height: deviceHeight(context) *.65,
                 alignment: Alignment.topLeft,
                 child: ToyGridList(),
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


