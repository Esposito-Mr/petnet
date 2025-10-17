import 'user_model.dart';

class Post {
  final String id;
  final User author;
  final String text;
  final String? imageUrl;
  final DateTime timestamp;

  const Post({
    required this.id,
    required this.author,
    required this.text,
    this.imageUrl,
    required this.timestamp,
  });
}