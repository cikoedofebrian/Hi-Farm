import 'package:hifarm/models/data/product_model.dart';
import 'package:hifarm/models/data/shop_model.dart';

class MCart {
  final MShop shop;
  final List<MInsideCart> productList;
  MCart({
    required this.shop,
    required this.productList,
  });
}

class MInsideCart {
  final MProduct product;
  int quantity;

  MInsideCart({
    required this.product,
    required this.quantity,
  });

  factory MInsideCart.fromJson(Map<String, dynamic> json) {
    return MInsideCart(
      product: MProduct.fromJson(json['product']),
      quantity: json['qty'],
    );
  }
}
