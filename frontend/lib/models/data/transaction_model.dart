import 'package:hifarm/models/data/adddress_model.dart';
import 'package:hifarm/models/data/shop_model.dart';
import 'package:hifarm/models/data/user_model.dart';
import 'package:hifarm/models/page_data/cart_model.dart';

class MTransaction {
  final int id;
  final String payment;
  final String status;
  final List<MInsideCart> products;
  final MUser customer;
  final MShop shop;
  final MAddress address;
  final DateTime date;
  MTransaction({
    required this.status,
    required this.address,
    required this.id,
    required this.products,
    required this.payment,
    required this.shop,
    required this.customer,
    required this.date,
  });

  factory MTransaction.fromJson(Map<String, dynamic> json) {
    List<MInsideCart> list = [];
    for (var i in json['detail_order']) {
      list.add(MInsideCart.fromJson(i));
    }
    return MTransaction(
      status: json['status'],
      id: json["id"],
      products: list,
      payment: json['payment'],
      address: MAddress.fromJson(json['address']),
      customer: MUser.fromJson(json['user']),
      shop: MShop.fromJson(json['shop']),
      date: DateTime.parse(json['created_at']),
    );
  }
}
