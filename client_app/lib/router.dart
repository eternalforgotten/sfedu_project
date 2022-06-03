import 'package:client_app/ui/cart/cart.dart';
import 'package:client_app/ui/chat/chat.dart';
import 'package:client_app/ui/item_page/item_page.dart';
import 'package:client_app/ui/main_menu_page/main_menu_page.dart';
import 'package:client_app/ui/order_info/order_info_page.dart';
import 'package:client_app/ui/user_authentication/authentication_code_page/authentication_code_page.dart';
import 'package:client_app/ui/user_authentication/authentication_number_page/authentication_number_page.dart';
import 'package:flutter/material.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) {
        return MainMenuPage();
      });
    case '/cart':
      return MaterialPageRoute(builder: (context) {
        return CartPage();
      });
    case '/item':
      return MaterialPageRoute(builder: (context) {
        return ItemPage(dish: settings.arguments);
      });
    case '/chat':
      return MaterialPageRoute(
        builder: (context) {
          return Chat();
        },
      );
    case '/phone':
      return MaterialPageRoute(
        builder: (context) {
          final args = settings.arguments as Map<String, Object>;
          final title = args['title'] as String;
          final action = args['needAction'] as bool;
          final page = args['page'] as String;
          return AuthenticationNumberPage(
            title,
            needAction: action,
            page: page,
          );
        },
      );
    case '/code':
      return MaterialPageRoute(
        builder: (context) {
          final args = settings.arguments as Map<String, Object>;
          final action = args['needAction'] as bool;
          final page = args['page'] as String;
          return AuthenticationCodePage(
            needAction: action,
            page: page,
          );
        },
      );
    case '/order':
      return MaterialPageRoute(
        builder: (context) {
          return OrderInfoPage();
        },
      );
    default:
      return MaterialPageRoute(
        builder: (_) {
          return Container();
        },
      );
  }
}
