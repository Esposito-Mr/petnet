// lib/pages/timeline_page.dart

import 'package:flutter/material.dart';
import '../data/mock_database.dart';
import '../models/post_model.dart';
import '../widgets/post_card.dart';

// This is now just the content for the timeline.
// The Scaffold, AppBar, etc. are all in MainShell.
class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key});

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  final MockDatabaseService _dbService = MockDatabaseService();
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = _dbService.getFeedPosts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: _postsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Ocorreu um erro ao carregar os posts.'));
        }
        if (snapshot.hasData) {
          final posts = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: posts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Card(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Compartilhe um momento...'),
                  ),
                );
              }
              final post = posts[index - 1];
              return PostCard(post: post);
            },
          );
        }
        return const Center(child: Text('Nenhum post encontrado.'));
      },
    );
  }
}