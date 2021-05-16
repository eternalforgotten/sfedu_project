import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final String description;
  Description(this.description);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: ResponsiveSize.responsiveWidth(24, context),
        left: ResponsiveSize.responsiveWidth(24, context),
        bottom: ResponsiveSize.responsiveHeight(10, context),
      ),
      child: Column(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Описание',
            style: TextStyle(
              fontSize: ResponsiveSize.responsiveHeight(18, context),
              color: Theme.of(context).textTheme.bodyText1.color,
            ),
          ),
          SizedBox(
            height: ResponsiveSize.responsiveHeight(6, context),
          ),
          Text(
            description,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontSize: ResponsiveSize.responsiveHeight(16, context),
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
