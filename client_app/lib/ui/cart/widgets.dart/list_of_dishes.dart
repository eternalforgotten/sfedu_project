import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_app/main.dart';
import 'package:client_app/repo.dart';
import 'package:client_app/responsive_size.dart';

import 'package:flutter/material.dart';
import 'dish_card_cart.dart';

class ListOfDishes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Repo.repoCart;
    return Container(
      height: ResponsiveSize.responsiveHeight(464, context),
      child: cart.length == 0
          ? Padding(
              padding: EdgeInsets.only(
                left: ResponsiveSize.responsiveWidth(24, context),
              ),
              child: Center(
                child: Text(
                  "Ваша корзина пуста",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontFamily:
                        Theme.of(context).textTheme.bodyText1.fontFamily,
                    fontSize: ResponsiveSize.responsiveHeight(18, context),
                  ),
                ),
              ),
            )
          : MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final String item = cart[index].name;
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    key: Key(item),
                    onDismissed: (DismissDirection dir) {
                      Repo.repoCart.removeAt(index);
                    },
                    background: Container(
                      child: Container(
                        height: ResponsiveSize.responsiveHeight(26, context),
                        width: ResponsiveSize.responsiveHeight(26, context),
                        
                      ),
                      alignment: Alignment.centerRight,
                    ),
                    child: DishCardCart(
                      caption: cart[index].subName,
                      price: cart[index].price,
                      count: cart[index].quantity,
                      image: cart[index].image,
                      name: cart[index].name,
                    ),
                  );
                },
              ),
            ),
    );
  }
}
