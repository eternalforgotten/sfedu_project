import 'package:client_app/business_logic/cart_bloc/cart_bloc.dart';
import 'package:client_app/responsive_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('dishes').snapshots(),
          builder: (ctx, snap) {
            var hasData = snap.hasData;
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
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .fontFamily,
                            fontSize:
                                ResponsiveSize.responsiveHeight(18, context),
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
                          var doc = hasData ? snap.data.docs[snap.data.docs.indexWhere((el) => el.id == cart[index].id)] : null;
                          final item = cart[index];
                          return Dismissible(
                            direction: DismissDirection.endToStart,
                            key: ValueKey(item.id),
                            onDismissed: (DismissDirection dir) {
                              cartBloc.add(RemoveEvent(item));
                            },
                            background: Container(
                              child: Container(
                                height: ResponsiveSize.responsiveHeight(
                                    26, context),
                                width: ResponsiveSize.responsiveHeight(
                                    26, context),
                              ),
                              alignment: Alignment.centerRight,
                            ),
                            child: DishCardCart(
                              pressUp: () =>
                                  cartBloc.add(AddOrIncrementEvent(item)),
                              pressDown: () =>
                                  cartBloc.add(DecrementEvent(item)),
                              caption: hasData ? doc['sub_name'] : item.subName,
                              price: hasData ? doc['price'] : item.price,
                              count: item.quantity,
                              image: item.image,
                              name: hasData ? doc['name'] : item.name,
                            ),
                          );
                        },
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
