import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toy_trader/firebase_services/DatabaseService.dart';
import 'package:toy_trader/screens/BottomNavBar.dart';
import 'package:toy_trader/screens/HomeScreen.dart';
import '../firebase_services/AuthService.dart';
import '../models/ProfileInfo.dart';
import 'package:image_picker/image_picker.dart';

import '../models/Toy.dart';
import '../widgets/CustomButton.dart';

class EditProfileScreen extends StatefulWidget {

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String dropdownValue1 = 'Action Figures';
  String dropdownValue2 = '0 - 2';
  ProfileInfo? userProfile;
  final _formKey = GlobalKey<FormState>();
  DatabaseService dbService = DatabaseService();
  AuthService authService = AuthService();
  File? image;
  Widget _body = CircularProgressIndicator();

  @override
  void initState() {
    getProfileInfo_setStateWhenDone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          title: IconButton(
            color: Colors.white,
            iconSize: physicalHeight / 11,
            icon: Image.asset('assets/images/logo.png'),
            onPressed: () {
              null;
            },
          ),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Done'))
        ],
      ),
      body: _body);
  }

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
  }

  void getProfileInfo_setStateWhenDone() async {
    userProfile = await dbService.getProfileInfo("");

    setState(() => _body = Stack(children: [
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          InkWell(
                            onTap: () {
                              pickImage(ImageSource.camera);
                            },
                            child: Container(
                                width: 120,
                                height: 120,
                                padding: const EdgeInsets.all(200),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 3, color: Colors.blue),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            userProfile!.profileImageUrl))))
                          ),
                          CustomButton(
                            title: 'Pick from Gallery',
                            icon: Icons.camera,
                            onClick: () => pickImage(ImageSource.gallery),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                hintText: 'Screen Name',
                              ),
                              validator: (val) => val!.isEmpty
                                  ? 'Screen name must not be empty'
                                  : null,
                              onChanged: (val) {
                                //setState(() => profileInfo.screenName = val);
                              }),
                          const SizedBox(height: 30.0),
                          const Text('Interests',
                            style: TextStyle(fontSize: 16),),
                          DropdownButton<String>(
                            isExpanded: true,
                            value: dropdownValue1,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.indigo, fontSize: 15),
                            underline: Container(
                              height: 2,
                              color: Colors.blue,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue1 = newValue!;
                                //profileInfo.interests = newValue;
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
                                child: Center(child: Text(value, style: TextStyle(fontSize: 15),)),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 20.0),
                          Text('Age Range',
                            style: TextStyle(fontSize: 16),),
                          DropdownButton<String>(
                            isExpanded: true,
                            value: dropdownValue2,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.indigo, fontSize: 15),
                            underline: Container(
                              height: 2,
                              color: Colors.blue,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue2 = newValue!;
                                //profileInfo.ageRange = newValue;
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
                                child: Center(child: Text(value, style: TextStyle(fontSize: 15),)),
                              );
                            }).toList(),
                          ),
                        ]))),
            const SizedBox(height: 0,)
          ],
        ),
      ),
    ]));
  }
}