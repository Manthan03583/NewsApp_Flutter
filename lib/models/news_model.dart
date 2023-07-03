class News {
  String title;
  String description;
  String imageURL;
  String source;

  News({
    required this.title,
    required this.description,
    required this.imageURL,
    required this.source,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      description: json['description'],
      source: json['source'],
      imageURL: json['imageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'source': source,
      'imageURL': imageURL,
    };
  }
}