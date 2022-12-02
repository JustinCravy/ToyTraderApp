import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toy_trader/screens/BottomNavBar.dart';
import 'package:toy_trader/screens/HomeScreen.dart';
import '../../../firebase_services/DatabaseService.dart';
import '../../../models/ProfileInfo.dart';
import '../../../models/Toy.dart';
import 'package:uuid/uuid.dart';

import '../models/AppColors.dart';
import '../widgets/CustomButton.dart';
import 'TradeHistoryScreen.dart';



class AddToyScreen extends StatefulWidget {

  final ProfileInfo profileInfo;
  const AddToyScreen({Key? key, required this.profileInfo}) : super(key: key);

  @override
  _AddToyScreenState createState() => _AddToyScreenState();
}

class _AddToyScreenState extends State<AddToyScreen> {
  String? conditionDropdownValue;
  String? categoryDropdownValue;
  String? ageRangeDropdownValue;
  String toyId = Uuid().v4();

  Toy toy = Toy('', '', '', '', '', '', '', '');

  DatabaseService dbService = DatabaseService();
  File? image;

  Future pickImage(ImageSource source) async{
    final image = await ImagePicker().pickImage(source: source);
    if (image ==null) return;

    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
  }

  @override
  Widget build(BuildContext context) {
      toy.toyId = toyId;
      toy.ownerId = widget.profileInfo.uid;
    return Scaffold(
        appBar: AppBar(
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'Trade History', 'Logout'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
            title: IconButton(
              color: Colors.white,
              iconSize: physicalHeight / 11,
              icon: Image.asset('assets/images/logo.png'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            )
        ),

        body: SingleChildScrollView (
            padding: EdgeInsets.symmetric(vertical:  deviceHeight(context) *.02, horizontal: deviceWidth(context) * .08),
            child: Column(children: <Widget>[
              InkWell(
                onTap: () {
                  pickImage(ImageSource.camera);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(image: image == null ? AssetImage('assets/images/click_to_add_img.png') : Image.file(image!).image,
                      width: double.infinity, height: 200),
                ),
              ),
              CustomButton(
                title: 'Pick from Gallery',
                icon: Icons.camera,
                onClick: () => pickImage(ImageSource.gallery),
              ),
              Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Toy Name',
                      ),
                      validator: (val) => val!.isEmpty ? 'Enter name' : null,
                      onChanged: (val) => toy.name = val,
                    ),
                    SizedBox(height: 5.0),
                    TextFormField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Description',
                        ),
                        validator: (val) => val!.length < 0 ? 'Enter description' : null,
                      onChanged: (val) => toy.description = val,
                    ),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: conditionDropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      hint: Text("Select Toy Condition"),
                      style: TextStyle(color: AppColors.prussianBlue),
                      onChanged: (String? newValue) {
                        setState(() {
                          conditionDropdownValue = newValue!;
                          toy.condition = newValue;
                        });
                      },
                      items: <String>[
                        'Acceptable',
                        'Good',
                        'Very Good',
                        'Like New',
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
                      style: TextStyle(color: AppColors.prussianBlue),
                      onChanged: (String? newValue) {
                        setState(() {
                          categoryDropdownValue = newValue!;
                          toy.categories = newValue;
                        });
                      },
                      items: <String>[
                        'Action Figures',
                        'Animals',
                        'Construction Toys',
                        'Creative Toys',
                        'Dolls',
                        'Educational Toys',
                        'Food related toys',
                        'Games',
                        'Model Building Toys',
                        'Musical Toys',
                        'Puzzle',
                        'Plush',
                        'Remote Controlled',

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
                      style: TextStyle(color: AppColors.prussianBlue),
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
                        onPressed: () async {
                        if(!toy.checkNullValue()){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Adding Toy"),
                          ));
                          await dbService.addToyData(toy, widget.profileInfo, image!);
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen())
                          );
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Incomplete"),
                            duration: Duration(seconds: 1),
                          ));
                        }
                      }),
                  ],
                ),
              ),
            ])));
  }
  void handleClick(String value) async {
    switch (value) {
      case 'Logout':
        await FirebaseAuth.instance.signOut();
        break;
      case 'Trade History':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TradeHistory()),
        );
        break;
    }
  }
}
