import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toy_trader/models/ProfileInfo.dart';
import '../../firebase_services/AuthService.dart';
import '../../models/Toy.dart';
import '../../widgets/CustomButton.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({Key? key}) : super(key: key);

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  String dropdownValue1 = 'Action Figures';
  String dropdownValue2 = '0 - 2';
  ProfileInfo profileInfo = ProfileInfo(
    uid: '',
    screenName: '',
    ageRange: '',
    interests: '',
    toys: <Toy>[],
    profileImageUrl: '',
    userRating: 0,
    totalRates: 0,
    blockedUsers: <String>[]
  );
  final _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  File? image;

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;
    return Scaffold(
      appBar: AppBar(
        title: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 90, 0),
            child: Image.asset('assets/images/logo.png')),
      ),
      body: Column(
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image(
                                image: image == null
                                    ? AssetImage(
                                        'assets/images/click_add_profile_img.png')
                                    : Image.file(image!).image,
                                width: double.infinity,
                                height: 200),
                          ),
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
                              setState(() => profileInfo.screenName = val);
                            }),
                        const SizedBox(height: 30.0),
                        const Text('Please select a categegory',
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
                              profileInfo.interests = newValue;
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
                        Text('Please select an age range',
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
                              profileInfo.ageRange = newValue;
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
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  elevation: 12.0,
                  textStyle:
                      const TextStyle(color: Colors.white, fontSize: 16)),
              child: const Text('Submit'),
              onPressed: () async {
                await authService.registerWithEmailAndPw(
                    args[0], args[1], profileInfo, image!);
                Navigator.of(context).pop();
              }),
          const SizedBox(height: 0,)

        ],
      ),
    );
  }
}


