import 'package:client_app/business_logic/chat_bloc/chat_bloc.dart';
import 'package:client_app/ui/cart/cart.dart';
import 'package:client_app/ui/chat/chat.dart';
import 'package:client_app/ui/item_page/item_page.dart';
import 'package:client_app/ui/main_menu_page/main_menu_page.dart';
import 'package:client_app/ui/order_verification/verification_code_page/verification_code_page.dart';
import 'package:client_app/ui/order_verification/verification_number_page/verification_number_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          return BlocProvider(
            create: (context) => ChatBloc()
              ..add(
                FetchChatEvent('89184735828'),
              ),
            child: Chat(),
          );
        },
      );
    case '/phone':
      return MaterialPageRoute(
        builder: (context) {
          return VerificationNumberPage();
        },
      );
    case '/code':
      return MaterialPageRoute(
        builder: (context) {
          return VerificationCodePage();
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
