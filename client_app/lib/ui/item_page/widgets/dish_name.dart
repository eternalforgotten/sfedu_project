import 'package:flutter/material.dart';

import '../../../responsive_size.dart';

class DishName extends StatelessWidget {
  final String title;
  DishName({this.title = 'Aнна Павловна'});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyText1.color,
        fontSize: ResponsiveSize.responsiveHeight(21, context),
      ),
    );
  }
}
