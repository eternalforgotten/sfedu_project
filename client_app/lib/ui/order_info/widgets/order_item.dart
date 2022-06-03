import 'package:client_app/classes/dish.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final Dish dish;
  const OrderItem(this.dish, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(
        vertical: 15,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black38
        ),
        borderRadius: BorderRadius.circular(30)
      ),
      child: Row(
        children: [
          Spacer(),
          Container(
            alignment: Alignment.centerLeft,
            width: 200,
            child: Text(
              dish.name,
            ),
          ),
          Spacer(
            flex: 3,
          ),
          Text(
            'x ${dish.quantity}',
          ),
          Spacer(),
          Text(
            '${dish.price} р',
          ),
          Spacer(),
        ],
      ),
    );
  }
}
