class Post {
  final int id;

  final String title;

  final String url;

  Post({required this.id, required this.title, required this.url});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'] ?? 'No title',
      url: json['url'] ?? '',
    );
  }
}
