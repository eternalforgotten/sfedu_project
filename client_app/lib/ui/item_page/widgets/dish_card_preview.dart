import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DishCardPreview extends StatelessWidget {
  final String price;
  final String image;
  DishCardPreview({this.price, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveSize.responsiveWidth(312, context),
      height: ResponsiveSize.responsiveHeight(341, context),
      decoration: BoxDecoration(
        color: Color(0xFFFEFBF8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            height: ResponsiveSize.responsiveHeight(281, context),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(image),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(
              bottom: ResponsiveSize.responsiveHeight(16, context),
              right: ResponsiveSize.responsiveWidth(20, context),
              left: ResponsiveSize.responsiveWidth(20, context),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Цена: ',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontSize: ResponsiveSize.responsiveHeight(16, context),
                  ),
                ),
                Text(
                  '$price ₽',
                  style: GoogleFonts.roboto(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontSize: ResponsiveSize.responsiveHeight(16, context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
