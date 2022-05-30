import 'package:client_app/classes/dish.dart';

class OrderData {
  final String userPhone;
  final List<Dish> dishes;
  final int totalPrice;

  OrderData({this.dishes, this.totalPrice, this.userPhone});

  Map<String, Object> toJson(){
    return {
      'user_phone': userPhone,
      'dishes': _dishesToJson(),
      'price': totalPrice,
    };
  }
  List<Map<String, Object>> _dishesToJson(){
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