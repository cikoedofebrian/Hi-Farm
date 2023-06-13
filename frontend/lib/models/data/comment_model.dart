import 'package:hifarm/models/data/user_model.dart';

class MComment {
  final MUser user;
  final String comment;
  final DateTime dateCreated;

  MComment({
    required this.user,
    required this.comment,
    required this.dateCreated,
  });

  factory MComment.fromJson(Map<String, dynamic> json) => MComment(
        user: MUser.fromJson(json['user']),
        comment: json['comment'],
        dateCreated: DateTime.parse(json['created_at']),
      );
}
