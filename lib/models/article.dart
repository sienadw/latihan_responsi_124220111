class Article {
  final int id;
  final String title;
  final String summary;
  final String url;
  final String imageUrl;
  final String publishedAt;

  Article({
    required this.id,
    required this.title,
    required this.summary,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      summary: json['summary'],
      url: json['url'],
      imageUrl: json['image_url'],
      publishedAt: json['published_at'],
    );
  }
}
