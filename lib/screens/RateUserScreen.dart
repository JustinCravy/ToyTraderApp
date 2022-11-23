
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../firebase_services/DatabaseService.dart';

class RateUserScreen extends StatefulWidget{
  final String id;

  const RateUserScreen ({Key? key, required this.id}) : super(key: key);
  @override
  State<RateUserScreen> createState() => _RatingState();
}

class _RatingState extends State<RateUserScreen>{
  DatabaseService dbService = DatabaseService();

  double rating=0;
  @override
  Widget build(BuildContext context) =>Scaffold(
    appBar: AppBar(
      title: Text("Rate this User"),
      centerTitle: true,
    ),
    body: Center(
        child: Column(
          children:<Widget> [
            SizedBox(
              height:200,
            ),
            RatingBar.builder(
              initialRating: 3,
              minRating:0,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) => setState(() {
                this.rating = rating;
              })),
            TextButton(
                child: const Text('submit'),
                onPressed: () async {
                  if (await dbService.rateUser(rating,widget.id)){
                    print('Rate successfully');
                  }
                  else
                    print('Error');
                }
                ),
          ]
      )
    )
  );
}