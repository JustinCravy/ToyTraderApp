import 'package:flutter/material.dart';
import 'package:toy_trader/screens/HomeScreen.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({Key? key}) : super(key: key);

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  String dropdownValue1 = 'Category One';
  String dropdownValue2 = '0 - 2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffC4DFCB),
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
      body: Container(
        // color: const Color(0xffC4DFCB),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Questionnaire Screen",
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Please select a categegory'),
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
                      Text('Please select an age range'),
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
                    ])),
            RaisedButton(
                child: const Text('To Home Screen'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                }),
          ],
        )),
      ),
    );
  }
}
