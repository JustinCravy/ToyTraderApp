import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class MainHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 1,
            child: Scaffold(
//                appBar: AppBar(
//                  title: Text(title),
//                ),
                body: SafeArea(
                    child: Column(children: <Widget>[
                      Container(
                        // color: Colors.white,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 2,

                         // child: const Align(
                         //   alignment: Alignment.center,
                         //   child: Text('Your \n profile',style: TextStyle(
                         //     fontSize: 30,
                         //   ),),
                         // ),

                        child: Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,150,0,0),

                              child: Align(
                                alignment: Alignment.center,
                                child: Text('1',style: TextStyle(
                                  fontSize: 30,

                                ),),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.fromLTRB(300,0,0,0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text('2',style: TextStyle(
                                  fontSize: 30,
                                ),),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.fromLTRB(0,0,300,0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text('5',style: TextStyle(
                                  fontSize: 30,
                                ),),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,0,0,0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Your \n profile',style: TextStyle(
                                  fontSize: 30,
                                ),),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.fromLTRB(150,50,0,0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('4',style: TextStyle(
                                  fontSize: 30,
                                ),),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.fromLTRB(0,0,150,0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('3',style: TextStyle(
                                  fontSize: 30,
                                ),),
                              ),
                            ),

                          ],
                        ),
                      ),

                        const Divider(),
                      //TabBarView(children: [ImageList(),])
                      Expanded(
                        child: Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,50,0,0),
                              child: SizedBox(
                                child: Center(child: Text(
                                  'Current preferences',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
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
                      ),
                    ])))));
  }
}
