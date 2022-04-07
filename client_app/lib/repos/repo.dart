import 'dart:collection';

import '../classes/dish.dart';

class CartRepository{
  List<Dish> _repoCart = [];

  void decrement(String id){
    final dish = _repoCart.firstWhere((element) => element.id == id);
    dish.quantity--;
  }
  void _increment(String id){
    final dish = _repoCart.firstWhere((element) => element.id == id);
    dish.quantity++;
  }
  void add(Dish dish){
    if (_repoCart.contains(dish)){
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