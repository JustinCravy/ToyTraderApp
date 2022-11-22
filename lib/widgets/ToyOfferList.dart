import 'package:flutter/material.dart';
import 'package:toy_trader/firebase_services/DatabaseService.dart';

import '../models/Toy.dart';
import '../models/Trade.dart';

class ToyOfferList extends StatefulWidget {
  late List<Toy> userToys;
  late List<Toy> recieverToys;
  late String title;

  ToyOfferList(this.userToys, this.recieverToys, {super.key});

  @override
  _ToyOfferListState createState() => _ToyOfferListState();
}

class _ToyOfferListState extends State<ToyOfferList> {

  late List<Toy> userToys;
  late List<Toy> receiverToys;
  late List<Toy> toys;
  late String title;
  late Map<int, bool> selectedFlag;
  late bool isSelectionMode;
  late int numberSelected;
  late int screenState;

  @override
  void initState() {
    userToys = widget.userToys;
    toys = userToys;
    receiverToys = widget.recieverToys;
    title = "Select Your Toys To Trade";
    selectedFlag = {};
    isSelectionMode = true;
    numberSelected = 0;
    screenState = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
          ),
        title: Text(title)),

      body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                  itemBuilder: (builder, index) {
                    Toy _toy = toys[index];
                    selectedFlag[index] = selectedFlag[index] ?? false;
                    bool? isSelected = selectedFlag[index];

                    return ListTile(
                        visualDensity: const VisualDensity(vertical: 3),
                        title: Text("${_toy.name}"),
                        subtitle: Text("Condition: ${_toy.condition}"),
                        leading: SizedBox(
                          height: 50,
                            width: 50,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(_toy.toyImageURL)
                                  )
                              ),
                            )
                        ),
                        trailing: _buildSelectIcon(isSelected!, _toy),
                        onTap: () => onTap(isSelected, index)
                    );

                  },
                  itemCount: toys.length,
                )
            ),
            ElevatedButton(
              onPressed: () => validateAndSaveToys(context),
              child: Text('Submit ($numberSelected) toys'),
            )
          ]
      ),
    );
  }

  void validateAndSaveToys(context) {
    if (screenState == 0) {
      if (numberSelected == 0) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Failed Offer'),
                content: const Text('You must select at least 1 toy'),
                actionsAlignment: MainAxisAlignment.center,
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        },
                  )
                ],
              );
            });
      }
      else {
        for (var i = 0; i < userToys.length; i++) {
          if (selectedFlag[i] == true) {
            widget.userToys.removeAt(i);
          }
        }
        updateScreen();
      }
    }

    else if (screenState == 1) {
      if (numberSelected == 0) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Failed Offer'),
                content: const Text('You must select at least 1 toy'),
                actionsAlignment: MainAxisAlignment.center,
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
      else {

        for (var i = 0; i < receiverToys.length; i++) {
          if (selectedFlag[i] == true) {
            widget.recieverToys.removeAt(i);
          }
        }
        Navigator.of(context).pop();
      }
    }
  }

  void updateScreen() {
    setState(() {
      toys = receiverToys;
      title = "Select The Toys You Want";
      screenState++;
      selectedFlag = {};
      isSelectionMode = true;
      numberSelected = 0;
    });
  }

  Widget _buildSelectIcon(bool isSelected, Toy toy) {
    return Icon(
      isSelected ? Icons.check_box : Icons.check_box_outline_blank,
      color: Theme.of(context).primaryColor,
    );
  }

  void onTap(bool isSelected, int index) {
    setState(() {
      if (selectedFlag[index] == true) {
        numberSelected--;
      }
      else {
        numberSelected++;
      }
      selectedFlag[index] = !isSelected;
      isSelectionMode = selectedFlag.containsValue(true);
    });
  }
}

