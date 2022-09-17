import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainHomeScreen extends StatelessWidget {
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

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: SizedBox(
                    child: Center(
                        child: Text(
                      'Current preferences',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                    height: 60,
                    width: 350,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(0),
                  child: SizedBox(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '-Interested in these toy categories...',
                      ),
                    ),
                    height: 60,
                    width: 350,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(0),
                  child: SizedBox(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '-Interested  in these age ranges...',
                      ),
                    ),
                    height: 60,
                    width: 350,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(0),
                  child: SizedBox(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'more...',
                      ),
                    ),
                    height: 60,
                    width: 350,
                  ),
                ),
              ],
            ),
    );
  }
}
