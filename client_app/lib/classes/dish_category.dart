import 'package:flutter/cupertino.dart';

class DishCategory {
  final String name;
  final IconData icon;

  DishCategory({this.icon, DishCategoryName categoryName})
      : name = categoryToName(categoryName);

  static String categoryToName(DishCategoryName categoryName) {
    switch (categoryName) {
      case DishCategoryName.all:
        return 'Все';
      case DishCategoryName.burgers:
        return 'Бургеры';
      case DishCategoryName.drinks:
        return 'Напитки';
      case DishCategoryName.mainCourse:
        return 'Первые блюда';
      case DishCategoryName.secondCourse:
        return 'Вторые блюда';
      case DishCategoryName.desserts:
        return 'Десерты';
      default:
        return '';
    }
  }

  static DishCategoryName nameToCategory(String categoryName) {
    switch (categoryName) {
      case 'Все':
        return DishCategoryName.all;
      case 'Бургеры':
        return DishCategoryName.burgers;
      case 'Напитки':
        return DishCategoryName.drinks;
      case 'Первые блюда':
        return DishCategoryName.mainCourse;
      case 'Вторые блюда':
        return DishCategoryName.secondCourse;
      case 'Десерты':
        return DishCategoryName.desserts;
    }
  }
}

enum DishCategoryName {
  all,
  burgers,
  mainCourse,
  secondCourse,
  drinks,
  desserts
}
