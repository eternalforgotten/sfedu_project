import 'dart:collection';

import '../classes/dish.dart';

class CartRepository{
  List<Dish> _repoCart = [];
  void updateCart(List<Dish> dishes){
    _repoCart.forEach((element) {
      var dish = dishes.firstWhere((newDish) => newDish.id == element.id);
      element.price = dish.price;
      element.subName = dish.subName;
      element.name = dish.name;
    });
  }
  void decrement(String id){
    final dish = _repoCart.firstWhere((element) => element.id == id);
    dish.quantity--;
  }
  void _increment(String id){
    final dish = _repoCart.firstWhere((element) => element.id == id);
    dish.quantity++;
  }
  void add(Dish dish){
    bool contains = false;
    for (int i = 0; i < _repoCart.length; i++){
      if (_repoCart[i].id == dish.id){
        contains = true;
        break;
      }
    }
    if (contains){
      _increment(dish.id);
    }
    else {
      _repoCart.add(dish);
    }
  }
  void remove(String id){
    var element = _repoCart.firstWhere((element) => element.id == id);
    element.quantity = 1;
    _repoCart.remove(element);
  }
  void clear(){
    _repoCart.forEach((element){
      remove(element.id);
    });
  }

  UnmodifiableListView<Dish> get cart => UnmodifiableListView(_repoCart);
}