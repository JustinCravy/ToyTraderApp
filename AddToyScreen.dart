import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../firebase_services/DatabaseService.dart';
import '../models/ProfileInfo.dart';
import '../models/Toy.dart';


class AddToyScreen extends StatefulWidget {
  @override
  _AddToyScreenState createState() => _AddToyScreenState();
}

class _AddToyScreenState extends State<AddToyScreen> {
  String? conditionDropdownValue;
  String? categoryDropdownValue;
  String? ageRangeDropdownValue;
  late Toy toy;


  DatabaseService dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    var profileInfo = ModalRoute.of(context)!.settings.arguments as ProfileInfo;
    return Scaffold(
        //body: Container(
        body: SingleChildScrollView (
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Column(children: <Widget>[
              Image.asset('assets/images/nerfgun1.jpg',
                  width: 556, height: 250),
              Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Toy Name',
                      ),
                      validator: (val) => {
                        toy.name = val!
                      }!.isEmpty ? 'Enter name' : null,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                        maxLines: 7,
                        decoration: InputDecoration(
                          hintText: 'Description',
                        ),
                        validator: (val) => {
                          toy.description = val!
                        }!.length < 0 ? 'Enter description' : null),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: conditionDropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      hint: Text("Select Toy Condition"),
                      style: const TextStyle(color: Colors.deepPurple),
                      onChanged: (String? newValue) {
                        setState(() {
                          conditionDropdownValue = newValue!;
                          toy.condition = newValue;
                        });
                      },
                      items: <String>[
                        'Barely works',
                        'Bad',
                        'Ok',
                        'Good',
                        'Great'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(child: Text(value)),
                        );
                      }).toList(),
                    ),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: categoryDropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      hint: Text("Select Toy Category"),
                      style: const TextStyle(color: Colors.deepPurple),
                      onChanged: (String? newValue) {
                        setState(() {
                          categoryDropdownValue = newValue!;
                          toy.categories = newValue;
                        });
                      },
                      items: <String>[
                        'Action Figures',
                        'Animals',
                        'Remote Controlled',
                        'Construction Toys',
                        'Creative Toys',
                        'Dolls',
                        'Educational Toys',
                        'Food related toys',
                        'Games',
                        'Model Building Toys',
                        'Puzzle',
                        'Muscial Toys'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(child: Text(value)),
                        );
                      }).toList(),
                    ),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: ageRangeDropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      hint: Text("Select Age Range"),
                      style: const TextStyle(color: Colors.deepPurple),
                      onChanged: (String? newValue) {
                        setState(() {
                          ageRangeDropdownValue = newValue!;
                          toy.ageRange = newValue;
                        });
                      },
                      items: <String>[
                        'All Ages',
                        '0-2',
                        '3-5',
                        '6-10',
                        '11-15',
                        '15+'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(child: Text(value)),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 40.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(40)
                      ),
                        child: Text('Add Toy'),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Sending Message"),
                          ));
                          dbService.addToyData(toy, profileInfo, null);
                        }),
                  ],
                ),
              ),
            ])));
  }
}
