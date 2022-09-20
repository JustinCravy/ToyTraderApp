import 'package:flutter/cupertino.dart';

import 'ToyBox.dart';

class ToyGridList extends StatelessWidget {
  const ToyGridList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(

        crossAxisCount: 2,

        children:  [
          ToyBox(),
          ToyBox(),
          ToyBox(),
          ToyBox(),
          ToyBox(),
          ToyBox(),
        ]
    );
  }
}