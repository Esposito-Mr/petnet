import 'package:flutter/material.dart';
import '../models/category_model.dart';

class CategoryCircle extends StatelessWidget {
  final Category category;

  const CategoryCircle({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: NetworkImage(category.imageUrl),
          onBackgroundImageError: (_, __) {}, // Handle image load errors
          child: NetworkImage(category.imageUrl).url.isEmpty
              ? const Icon(Icons.category) // Placeholder if no image
              : null,
        ),
        const SizedBox(height: 8),
        Text(category.name, textAlign: TextAlign.center),
      ],
    );
  }
}