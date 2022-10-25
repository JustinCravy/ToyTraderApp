import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../firebase_services/DatabaseService.dart';
import '../../../models/ProfileInfo.dart';
import '../../../models/Toy.dart';
import 'package:uuid/uuid.dart';



class AddToyScreen extends StatefulWidget {
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
    var profileInfo = ModalRoute.of(context)!.settings.arguments as ProfileInfo;
    print(profileInfo.uid);
    toy.toyId = toyId;
    toy.ownerId = profileInfo.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Toy Trader",
          style: TextStyle(
            // color: Theme.of(context).primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),

        ),
      ),
        body: SingleChildScrollView (
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Column(children: <Widget>[
              SizedBox(height: 30.0,),
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
                    SizedBox(height: 20.0),
                    TextFormField(
                        maxLines: 7,
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
                        onPressed: () async {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Sending Message"),
                          ));
                          await dbService.addToyData(toy, profileInfo, image);
                        }),
                  ],
                ),
              ),
            ])));
  }
}
