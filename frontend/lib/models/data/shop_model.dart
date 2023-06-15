import 'package:google_maps_flutter/google_maps_flutter.dart';

class MShop {
  final int id;
  final String name;
  final LatLng loc;
  final String address;
  final DateTime dateCreated;
  final String description;

  MShop({
    required this.id,
    required this.name,
    required this.address,
    required this.dateCreated,
    required this.loc,
    required this.description,
  });

  factory MShop.fromJson(Map<String, dynamic> json) {
    return MShop(
      id: json["id"],
      address: json['address'],
      dateCreated: DateTime.parse(json['created_at']),
      loc: LatLng(json['lt'], json['ln']),
      name: json['name'],
      description: json['description'],
    );
  }
}
