import 'package:client_app/classes/dish.dart';
import 'package:client_app/responsive_size.dart';
import 'package:client_app/ui/item_page/widgets/cart_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'widgets/pop_back_button.dart';

import 'widgets/description.dart';
import 'widgets/dish_card_preview.dart';
import 'widgets/dish_name.dart';
import 'widgets/dish_subtitle.dart';
import 'widgets/navbar.dart';

class ItemPage extends StatelessWidget {
  final Dish dish;

  ItemPage({@required this.dish});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 88,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      right: ResponsiveSize.responsiveWidth(24, context),
                      left: ResponsiveSize.responsiveWidth(24, context),
                      top: ResponsiveSize.responsiveHeight(14, context),
                      bottom: ResponsiveSize.responsiveHeight(30, context),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        PopBackButton(),
                        CartButton(),
                      ],
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('dishes').snapshots(),
                    builder: (context, snapshot) {
                      var hasData = snapshot.hasData;
                      var data = hasData 
                      ? snapshot.data.docs[snapshot.data.docs.indexWhere((element) => element.id == dish.id)] 
                      : null;
                      return Container(
                        height: ResponsiveSize.responsiveHeight(536, context),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  right: ResponsiveSize.responsiveWidth(24, context),
                                  left: ResponsiveSize.responsiveWidth(24, context),
                                  bottom:
                                      ResponsiveSize.responsiveHeight(20, context),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    DishName(title: hasData ? data['name'] : dish.name),
                                    SizedBox(
                                      height:
                                          ResponsiveSize.responsiveHeight(8, context),
                                    ),
                                    DishSubtitle(subtitle: hasData ? data['sub_name'] : dish.subName),
                                  ],
                                ),
                              ),
                              DishCardPreview(
                                price: hasData ? data['price'] : dish.price,
                                image: dish.image,
                              ),
                              SizedBox(
                                height: ResponsiveSize.responsiveHeight(24, context),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Description(hasData ? data['description'] : dish.description),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 12,
              child: Navbar(dish),
            ),
          ],
        ),
      ),
    );
  }
}
