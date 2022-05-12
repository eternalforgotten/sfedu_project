import 'package:client_app/business_logic/auth_bloc/auth_bloc.dart';
import 'package:client_app/business_logic/cart_bloc/cart_bloc.dart';
import 'package:client_app/business_logic/chat_bloc/chat_bloc.dart';
import 'package:client_app/responsive_size.dart';
import 'package:client_app/ui/user_authentication/verification_appbar.dart';
import 'package:client_app/ui/user_authentication/authentication_code_page/widgets/enter_code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationCodePage extends StatelessWidget {
  final VoidCallback action;
  AuthenticationCodePage({this.action});
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
        if (state is UserAuthenticatedState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/chat',
            (route) => route.isFirst,
            arguments: state.userPhone,
          );
          if (action != null) {
            final cartBloc = BlocProvider.of<CartBloc>(context);
            final userCart = cartBloc.cart.cart;
            final total = cartBloc.recalculate();
            BlocProvider.of<ChatBloc>(context).add(
              SendOrderMessageEvent(
                action:() => cartBloc.add(ClearEvent()),
                number: state.userPhone,
                dishes: userCart,
                total: total,
              ),
            );
            
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              VerificationAppbar("Код подтверждения"),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ResponsiveSize.responsiveWidth(24, context),
                      ),
                      child: Text(
                        "Мы отправили Вам код подтверждения на указанный ранее номер телефона",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2.color,
                          fontFamily:
                              Theme.of(context).textTheme.bodyText2.fontFamily,
                          fontSize:
                              ResponsiveSize.responsiveHeight(18, context),
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(
                      height: ResponsiveSize.responsiveHeight(55, context),
                    ),
                    EnterCodeTextField(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
