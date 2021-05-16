import 'package:flutter/cupertino.dart';

class ResponsiveSize{
  static double responsiveHeight(double size, BuildContext context){
    var height = MediaQuery.of(context).size.height;
    return size * (height / 740);
  }

  static double responsiveWidth(double size, BuildContext context){
    var width = MediaQuery.of(context).size.width;
    return size * (width / 360);
  }
}