import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  String dropdownValue1 = 'Category One';
  String dropdownValue2 = '0 - 2';
  String dropdownValue3 = 'Interested1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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


    );
  }
}
