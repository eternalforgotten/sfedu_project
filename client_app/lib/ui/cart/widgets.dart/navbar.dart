import 'dart:async';

import 'package:client_app/added_dish_snackbar.dart';
import 'package:client_app/business_logic/auth_bloc/auth_bloc.dart';
import 'package:client_app/business_logic/cart_bloc/cart_bloc.dart';
import 'package:client_app/business_logic/chat_bloc/chat_bloc.dart';
import 'package:client_app/business_logic/dish_bloc/dish_bloc.dart';
import 'package:client_app/responsive_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Navbar extends StatefulWidget {
  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  StreamSubscription streamSubscription;
  @override
  void initState() {
    streamSubscription = FirebaseFirestore.instance
        .collection('dishes')
        .snapshots()
        .listen((event) {
      BlocProvider.of<DishBloc>(context, listen: false).add(FetchEvent());
      BlocProvider.of<CartBloc>(context, listen: false).add(CartChangedEvent());
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: ResponsiveSize.responsiveWidth(25, context),
      ),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (inner, state) {
          var sum = 0;
          if (state is CartChangedState) {
            sum = state.totalSum;
          }
          return Row(
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
                      fontFamily:
                          Theme.of(context).textTheme.bodyText2.fontFamily,
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
                onTap: () {
                  final user = BlocProvider.of<AuthBloc>(context).currentUser;
                  final cartBloc = BlocProvider.of<CartBloc>(context);
                  final userCart = cartBloc.cart.cart;
                  final total = cartBloc.recalculate();
                  if (userCart.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      simpleSnackBar("Добавьте блюда в корзину!"),
                    );
                    return;
                  }
                  if (user == null) {
                    Navigator.of(context).pushNamed(
                      '/phone',
                      arguments: {
                        'title':
                            "Для оформления заказа введите номер телефона. На него придёт СМС с кодом подтверждения.",
                        'needAction': true,
                      },
                    );
                  } else {
                    BlocProvider.of<ChatBloc>(context).add(
                      SendOrderMessageEvent(
                        number: user.phoneNumber,
                        dishes: userCart,
                        total: total,
                        action: () => cartBloc.add(ClearEvent()),
                      ),
                    );
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/chat',
                      (route) => route.isFirst,
                      arguments: user.phoneNumber,
                    );
                  }
                },
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
          );
        },
      ),
    );
  }
}
