import 'package:client_app/business_logic/cart_bloc/cart_bloc.dart';
import 'package:client_app/repos/repo.dart';
import 'package:client_app/responsive_size.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dish_card_cart.dart';

class ListOfDishes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartBloc = BlocProvider.of<CartBloc>(context);
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        var cart = cartBloc.cart.cart;
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
                      final item = cart[index];
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        key: ValueKey(item.id),
                        onDismissed: (DismissDirection dir) {
                          cartBloc.add(RemoveEvent(item));
                        },
                        background: Container(
                          child: Container(
                            height:
                                ResponsiveSize.responsiveHeight(26, context),
                            width: ResponsiveSize.responsiveHeight(26, context),
                          ),
                          alignment: Alignment.centerRight,
                        ),
                        child: DishCardCart(
                          pressUp: () => cartBloc.add(AddOrIncrementEvent(item)),
                          pressDown: () => cartBloc.add(DecrementEvent(item)),
                          caption: item.subName,
                          price: item.price,
                          count: item.quantity,
                          image: item.image,
                          name: item.name,
                        ),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
