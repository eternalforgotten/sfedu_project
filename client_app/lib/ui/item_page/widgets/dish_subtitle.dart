import 'package:flutter/material.dart';

import '../../../responsive_size.dart';

class DishSubtitle extends StatelessWidget {
  final String subtitle;
  DishSubtitle({this.subtitle = '110 г / 319 каллорий'});

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: ResponsiveSize.responsiveHeight(16, context),
        color: Color(0xffA3AEB2),
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
