import 'package:hifarm/models/data/shop_model.dart';

class MProduct {
  final int id;
  final String name;
  final String image;
  final int price;
  final String city;
  final MShop shop;

  MProduct({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.shop,
    required this.city,
  });

  factory MProduct.fromJson(Map<String, dynamic> json) {
    return MProduct(
      id: json["id"],
      city: json['city'],
      image: json['pic']['url'],
      price: json['price'],
      name: json['name'],
      shop: MShop.fromJson(json['shop']),
    );
  }
}
