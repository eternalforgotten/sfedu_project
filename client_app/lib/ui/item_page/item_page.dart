import 'package:client_app/classes/dish.dart';
import 'package:client_app/responsive_size.dart';
import 'package:client_app/ui/item_page/widgets/cart_button.dart';
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
    return Scaffold(
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
                    top: ResponsiveSize.responsiveHeight(45, context),
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
                Container(
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
                              DishName(title: dish.name),
                              SizedBox(
                                height:
                                    ResponsiveSize.responsiveHeight(8, context),
                              ),
                              DishSubtitle(subtitle: dish.subName),
                            ],
                          ),
                        ),
                        DishCardPreview(
                          price: dish.price,
                          image: dish.image,
                        ),
                        SizedBox(
                          height: ResponsiveSize.responsiveHeight(24, context),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Description("Описание товара, добавить в поле"),
                        ),
                      ],
                    ),
                  ),
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
    );
  }
}
