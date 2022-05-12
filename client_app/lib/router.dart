import 'package:client_app/business_logic/chat_bloc/chat_bloc.dart';
import 'package:client_app/ui/cart/cart.dart';
import 'package:client_app/ui/chat/chat.dart';
import 'package:client_app/ui/item_page/item_page.dart';
import 'package:client_app/ui/main_menu_page/main_menu_page.dart';
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
          final action = args['action'] as VoidCallback;
          return AuthenticationNumberPage(
            title,
            action: action,
          );
        },
      );
    case '/code':
      return MaterialPageRoute(
        builder: (context) {
          return AuthenticationCodePage(action: settings.arguments as VoidCallback);
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
