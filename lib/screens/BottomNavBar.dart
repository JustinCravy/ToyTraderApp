import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toy_trader/widgets/MessageList.dart';
import 'package:toy_trader/widgets/ToyGridList.dart';
import '../firebase_services/AuthService.dart';
import '../firebase_services/DatabaseService.dart';
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
  //String dropdownValue1 = 'Category One';
  //String dropdownValue2 = '0 - 2';
  //String dropdownValue3 = 'Interested1';

  @override
  Widget build(BuildContext context) {
    final DatabaseService dbService = DatabaseService();

    return Scaffold(
        body: SingleChildScrollView(
          child: RaisedButton(
            onPressed: () async {
              var profileInfo = await dbService.getProfileInfo("");
              for(var i = 0; i <profileInfo.length; i++) {
                print("${profileInfo[i].userId}, ${profileInfo[i].screenName}");
              }
            },
          ),
        )
    );
    /*
    return Scaffold(
        body: SingleChildScrollView(
        child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: const Image(
                  image: AssetImage('assets/images/profile_pic_place_holder.png'),
                ),
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: const Image(
                  image: AssetImage('assets/images/profile_pic_place_holder.png'),
                ),
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
              ),
              Container(
                child: const Image(
                  image: AssetImage(
                      'assets/images/profile_pic_place_holder_main.png'),
                ),
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              ),
              Container(
                child: const Image(
                  image: AssetImage('assets/images/profile_pic_place_holder.png'),
                ),
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: const Image(
                  image: AssetImage('assets/images/profile_pic_place_holder.png'),
                ),
                padding: const EdgeInsets.fromLTRB(0, 30, 30, 0),
              ),
              Container(
                child: const Image(
                  image: AssetImage('assets/images/profile_pic_place_holder.png'),
                ),
                padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
              )
            ],
          ),
          SizedBox(height: 20.0),
          Text(
            "Current Preferences",
            style: TextStyle(
              color: Colors.blue[900],
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Interested in these toy categories'),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue1,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue1 = newValue!;
                        });
                      },
                      items: <String>[
                        'Category One',
                        'Category Two',
                        'Category Three',
                        'Category Four',
                        'More Categories'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(child: Text(value)),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20.0),
                    Text('Interested in these age ranges'),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue2,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue2 = newValue!;
                        });
                      },
                      items: <String>[
                        '0 - 2',
                        '2 - 5',
                        '5 - 10',
                        '10 - 15',
                        '15 - 18',
                        '> 18'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(child: Text(value)),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20.0),
                    Text('More Interested'),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue3,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue3 = newValue!;
                        });
                      },
                      items: <String>[
                        'Interested1',
                        'Interested2',
                        'Interested3',
                        'Interested4',
                        '1Interested5'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(child: Text(value)),
                        );
                      }).toList(),
                    ),
                  ]
              )
          ),
        ],
      ),
      )
    );*/
  }
}

class MainScreen extends StatelessWidget{
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileInfo = ModalRoute.of(context)!.settings.arguments as ProfileInfo?;
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


