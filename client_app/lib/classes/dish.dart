import 'package:cached_network_image/cached_network_image.dart';

class Dish {
  final int id;
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
}