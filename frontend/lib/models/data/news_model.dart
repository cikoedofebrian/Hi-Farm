class MNews {
  final int id;
  final String judul;
  final String description;
  final String url;

  MNews({
    required this.id,
    required this.judul,
    required this.description,
    required this.url,
  });

  factory MNews.fromJson(Map<String, dynamic> json) => MNews(
        id: json["id"],
        judul: json["title"],
        description: json["description"],
        url: json["pic"]["url"],
      );
}
