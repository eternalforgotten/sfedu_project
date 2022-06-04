import 'package:client_app/classes/dish.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class OrderData {
  final String userPhone;
  final List<Dish> dishes;
  final int totalPrice;
  final Timestamp timestamp;

  OrderData({
    @required this.dishes,
    @required this.totalPrice,
    @required this.userPhone,
    @required this.timestamp,
  });

  Map<String, Object> toJson() {
    return {
      'user_phone': userPhone,
      'dishes': _dishesToJson(),
      'price': totalPrice,
      'timestamp': timestamp,
    };
  }

  List<Map<String, Object>> _dishesToJson() {
    final list = dishes;
    final List<Map<String, Object>> result = [];
    list.forEach((dish) {
      Map<String, Object> jsonDish;
      jsonDish = {
        'id': dish.id,
        'price': dish.price,
        'quantity': dish.quantity,
        'name': dish.name,
      };
      result.add(jsonDish);
    });
    return result;
  }
}
