import 'package:client_app/added_dish_snackbar.dart';
import 'package:client_app/classes/dish.dart';
import 'package:client_app/main.dart';
import 'package:client_app/repo.dart';
import 'package:client_app/responsive_size.dart';
import 'package:client_app/ui/cart/widgets.dart/dish_card_cart.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final Dish dish;

  Navbar(this.dish);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(
        left: ResponsiveSize.responsiveWidth(25, context),
      ),
      child: GestureDetector(
        onTap: () {
          if (Repo.repoCart.contains(dish)) {
            dish.quantity++;
          } else {
            Repo.repoCart.add(dish);
          }
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(addedDishSnackBar());
        },
        child: Container(
          width: ResponsiveSize.responsiveWidth(220, context),
          height: ResponsiveSize.responsiveHeight(52, context),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Center(
            child: Text(
              'Добавить',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: ResponsiveSize.responsiveHeight(18, context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
