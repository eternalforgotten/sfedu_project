import 'package:client_app/business_logic/dish_bloc/dish_bloc.dart';
import 'package:client_app/ui/cart/cart.dart';
import 'package:client_app/ui/chat/chat.dart';
import 'package:client_app/ui/item_page/item_page.dart';
import 'package:client_app/ui/main_menu_page/main_menu_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) {
        return BlocProvider(
          create: (context) => DishBloc(FirebaseFirestore.instance)..add(FetchEvent()),
          child: MainMenuPage(),
        );
      });
    case '/cart':
      return MaterialPageRoute(builder: (_) {
        return CartPage();
      });
    case '/item':
      return MaterialPageRoute(builder: (_) {
        return ItemPage(dish: settings.arguments);
      });
    case '/chat':
      return MaterialPageRoute(
        builder: (_) {
          return Chat();
        },
      );
    default:
      return MaterialPageRoute(builder: (_) {
        return Container();
      });
  }
}
