import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';

class NameBlock extends StatelessWidget {
  const NameBlock();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.responsiveWidth(24, context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Ресторан",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2.color,
                  fontFamily: Theme.of(context).textTheme.bodyText2.fontFamily,
                  fontSize: ResponsiveSize.responsiveHeight(18, context),
                ),
              ),
              SizedBox(
                height: ResponsiveSize.responsiveHeight(4, context),
              ),
              Text(
                "MealTime",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: ResponsiveSize.responsiveHeight(32, context),
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: ResponsiveSize.responsiveHeight(38, context),
            backgroundImage: ResizeImage(
              AssetImage('assets/mealtime.png'),
              height: (ResponsiveSize.responsiveHeight(38, context) * 4).ceil(),
              width: (ResponsiveSize.responsiveHeight(38, context) * 4).ceil(),
            ),
          ),
        ],
      ),
    );
  }
}
