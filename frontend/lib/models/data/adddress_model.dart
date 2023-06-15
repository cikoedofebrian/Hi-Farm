import 'package:google_maps_flutter/google_maps_flutter.dart';

class MAddress {
  final int id;
  final String title;
  final LatLng loc;
  final String address;
  final int phone;

  MAddress({
    required this.id,
    required this.title,
    required this.loc,
    required this.address,
    required this.phone,
  });

  factory MAddress.fromJson(Map<String, dynamic> json) => MAddress(
        title: json["title"],
        id: json['id'],
        loc: LatLng(json['lt'], json['ln']),
        address: json["address"],
        phone: int.tryParse(json["phone"])!,
      );
}
