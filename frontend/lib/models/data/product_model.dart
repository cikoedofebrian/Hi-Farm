import 'package:hifarm/models/data/shop_model.dart';

class MProduct {
  final int id;
  final String name;
  final String image;
  final int price;
  final String city;
  final MShop? shop;
  final String description;

  MProduct(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.shop,
      required this.city,
      required this.description});

  factory MProduct.fromJson(Map<String, dynamic> json) {
    return MProduct(
      id: json["id"],
      city: json['city'],
      image: json['pic']['url'],
      price: json['price'],
      name: json['name'],
      description: json['description'],
      shop: json.containsKey('shop') ? MShop.fromJson(json['shop']) : null,
    );
  }
}
