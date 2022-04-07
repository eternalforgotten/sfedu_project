import 'package:cached_network_image/cached_network_image.dart';

class Dish {
  final String id;
  final String name;
  final String subName;
  final String price;
  CachedNetworkImageProvider image;
  int quantity = 1;
  final String description;

  Dish({
    this.id,
    this.image,
    this.name,
    this.price,
    this.subName,
    this.description,
  });

  Dish.fromJson(Map<String, dynamic> json, String firebaseId) : 
    id = firebaseId,
    image = CachedNetworkImageProvider(json['image_url']),
    description = json['description'],
    name = json['name'],
    price = json['price'].toString(),
    subName = json['sub_name'];
}