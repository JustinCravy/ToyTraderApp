import 'package:flutter/cupertino.dart';

class DeviceDim{

  getheight(BuildContext context){
    double height;
    return height = deviceHeight(context);
  }
  getwidth(BuildContext context){
    double height;
    return height = deviceHeight(context);
  }
  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
}