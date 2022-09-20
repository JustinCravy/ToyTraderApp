import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

import 'QuestionnaireScreen.dart';



class PhotoAndNameScreen extends StatefulWidget {
  const PhotoAndNameScreen({Key? key}) : super(key: key);

  @override
  _PhotoAndNameState createState() => _PhotoAndNameState();

}

class _PhotoAndNameState extends State<PhotoAndNameScreen>{
  File? image;

  Future pickImage(ImageSource source) async{
    final image = await ImagePicker().pickImage(source: source);
    if (image ==null) return;

    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick an image for your profile'),
      ),
      body: Center(
        child: Column(
          children:[
            SizedBox(height: 20),
            image != null
                ? Image.file(
                      image!,
                      width:200,
                      height: 200,
              fit:BoxFit.cover,
            ): Image.asset('assets/images/logo.png',
                 width:200,
                 height:200),
            SizedBox(height: 20,),
            CustomButton(
              title: 'Pick from Gallery',
              icon: Icons.image_outlined,
              onClick: () => pickImage(ImageSource.gallery),
            ),
            SizedBox(height: 10,),
            CustomButton(
              title: 'Pick from Camera',
              icon: Icons.camera,
              onClick: () => pickImage(ImageSource.camera),
            ),
            SizedBox(height:60),
            RaisedButton(
              child: Text('Next step'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuestionnaireScreen()));
              }
            )
          ]

        )
      )
    );
  }

}

Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  return Container(
    width: 280,
    child: ElevatedButton(
      onPressed: onClick,
      child: Row(
        children:[
          Icon(icon),
          SizedBox(
            width: 20,
          ),
          Text(title)
        ],
      ),
    ),
  );
}
