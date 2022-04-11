import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_app/classes/dish_category.dart';

class Dish {
  final String id;
  String name;
  String subName;
  String price;
  String image;
  int quantity = 1;
  final String description;
  final DishCategoryName category;

  Dish({
    this.id,
    this.image,
    this.name,
    this.price,
    this.subName,
    this.description,
    this.category,
  });

  Dish.fromJson(Map<String, dynamic> json, String firebaseId)
      : id = firebaseId,
        category = DishCategory.nameToCategory(json['category']),
        image = json['image_url'],
        description = json['description'],
        name = json['name'],
        price = json['price'].toString(),
        subName = json['sub_name'];
}
