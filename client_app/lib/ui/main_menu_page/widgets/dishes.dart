import 'package:client_app/classes/dish.dart';
import 'package:client_app/responsive_size.dart';
import 'package:flutter/material.dart';

import 'dish_card.dart';

class Dishes extends StatelessWidget {
  final List<Dish> dishes;

  Dishes({@required this.dishes});

  List<DishCard> makeDishCards() {
    List<DishCard> cards = [];

    for (int i = 0; i < dishes.length; i++)
      cards.add(DishCard(
        dish: dishes[i],
      ));

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    var cards = makeDishCards();

    return Container(
      height: ResponsiveSize.responsiveHeight(341, context),
      padding: EdgeInsets.only(
        bottom: ResponsiveSize.responsiveHeight(20, context),
      ),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          itemCount: cards.length,
          itemBuilder: (_, index) => cards[index],
          separatorBuilder: (_, index) => SizedBox(
            height: ResponsiveSize.responsiveHeight(16, context),
          ),
        ),
      ),
    );
  }
}
