class MUser {
  final int id;
  final String name;
  final String email;
  final int? picId;
  final String? pic;

  MUser({
    required this.id,
    required this.name,
    required this.email,
    required this.pic,
    required this.picId,
  });

  factory MUser.fromJson(Map<String, dynamic> json) => MUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        pic: json['pic'] != null ? json['pic']['url'] : null,
        picId: json['picture_id'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };
}
