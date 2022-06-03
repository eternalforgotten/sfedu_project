import 'package:client_app/business_logic/auth_bloc/auth_bloc.dart';
import 'package:client_app/business_logic/cart_bloc/cart_bloc.dart';
import 'package:client_app/business_logic/chat_bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateOrderButton extends StatelessWidget {
  const CreateOrderButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthBloc>(context).currentUser;
    final cartBloc = BlocProvider.of<CartBloc>(context);
    final userCart = cartBloc.cart.cart;
    final total = cartBloc.recalculate();
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          minimumSize: Size(
            200,
            50,
          ),
          primary: Theme.of(context).primaryColor,
        ),
        child: Text(
          'Оформить заказ',
        ),
        onPressed: () {
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
            (r) => r.isFirst,
          );
        },
      ),
    );
  }
}
