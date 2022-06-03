import 'package:client_app/business_logic/cart_bloc/cart_bloc.dart';
import 'package:client_app/ui/order_info/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderInfoWidget extends StatelessWidget {
  const OrderInfoWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dishes = BlocProvider.of<CartBloc>(context).cart.cart;
    return Column(
      children: [
        ...dishes.map((dish) => OrderItem(dish)).toList(),
        
      ],
    );
  }
}
