import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DishCardCart extends StatelessWidget {
  final String name;
  final String price;
  final String caption;
  final int count; //Кол-во в заказе на данный момент
  final Function pressUp; // Плюсик
  final Function pressDown; //Минусик
  final String image;
  //final Function pressDel;

  const DishCardCart(
      {Key key,
      this.name,
      this.price,
      this.caption,
      this.count,
      this.pressUp,
      this.pressDown,
      this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: ResponsiveSize.responsiveWidth(56, context),
        bottom: ResponsiveSize.responsiveHeight(16, context),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            width: ResponsiveSize.responsiveWidth(309, context),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    width: ResponsiveSize.responsiveWidth(241, context),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          width: ResponsiveSize.responsiveWidth(64, context),
                        ),
                        Container(
                          width: ResponsiveSize.responsiveWidth(173, context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: ResponsiveSize.responsiveHeight(
                                    16, context),
                              ),
                              Text(
                                name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: ResponsiveSize.responsiveHeight(
                                      18, context),
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                caption,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .color,
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .fontFamily,
                                  fontSize: ResponsiveSize.responsiveHeight(
                                      12, context),
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                '$price ₽',
                                style: GoogleFonts.roboto(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .color,
                                  fontSize: ResponsiveSize.responsiveHeight(
                                      18, context),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: ResponsiveSize.responsiveWidth(8, context),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: pressUp,
                          child: Icon(
                            Icons.add,
                            size: ResponsiveSize.responsiveHeight(24, context),
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          count.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize:
                                ResponsiveSize.responsiveHeight(18, context),
                          ),
                        ),
                        GestureDetector(
                          onTap: pressDown,
                          child: Icon(
                            Icons.remove,
                            size: ResponsiveSize.responsiveHeight(24, context),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: ResponsiveSize.responsiveWidth(-30.4, context),
            child: ClipOval(
              child: Container(
                width: ResponsiveSize.responsiveHeight(76, context),
                height: ResponsiveSize.responsiveHeight(76, context),
                child: Image(
                  fit: BoxFit.cover,
                  image: ResizeImage(
                    CachedNetworkImageProvider(image),
                    width: ResponsiveSize.responsiveWidth(200, context).round(),
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
