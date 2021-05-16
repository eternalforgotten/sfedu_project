import 'package:client_app/repo.dart';
import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var sum = 0;
    Repo.repoCart
        .forEach((dish) => sum += dish.quantity * int.parse(dish.price));
    return Container(
      padding: EdgeInsets.only(
        left: ResponsiveSize.responsiveWidth(25, context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Итого:',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2.color,
                  fontFamily: Theme.of(context).textTheme.bodyText2.fontFamily,
                  fontSize: ResponsiveSize.responsiveHeight(16, context),
                ),
              ),
              Text(
                sum.toString() + " р",
                style: GoogleFonts.roboto(
                  fontSize: ResponsiveSize.responsiveHeight(20, context),
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: ResponsiveSize.responsiveWidth(220, context),
              height: ResponsiveSize.responsiveHeight(52, context),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    ResponsiveSize.responsiveWidth(10, context),
                  ),
                  bottomLeft: Radius.circular(
                    ResponsiveSize.responsiveWidth(10, context),
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  'Заказать',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ResponsiveSize.responsiveWidth(18, context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
