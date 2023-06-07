import 'package:hifarm/models/data/user_model.dart';

class MPost {
  final int id;
  final String description;
  final double ln;
  final double lt;
  final int userId;
  final List<String> pics;
  final MUser user;

  MPost({
    required this.id,
    required this.description,
    required this.ln,
    required this.lt,
    required this.userId,
    required this.pics,
    required this.user,
  });

  factory MPost.fromJson(Map<String, dynamic> json) {
    List<String> picUrls = [];
    json["pics"].forEach((pic) {
      picUrls.add(pic["url"]);
    });

    return MPost(
      id: json["id"],
      description: json["description"],
      ln: json["ln"]?.toDouble(),
      lt: json["lt"]?.toDouble(),
      userId: json["user_id"],
      pics: picUrls,
      user: MUser.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "ln": ln,
        "lt": lt,
        "user_id": userId,
        "pics": pics,
        "user": user.toJson(),
      };
}
