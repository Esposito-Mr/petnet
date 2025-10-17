import 'package:flutter/material.dart';
import '../models/ngo_model.dart';

class NGOCard extends StatelessWidget {
  final NGO ngo;

  const NGOCard({super.key, required this.ngo});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300, width: 1), // Subtle border
      ),
      elevation: 0, // Flat design as per image
      color: Theme.of(context).cardColor, // Use theme card color
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
          children: [
            Expanded(
              child: Image.network(
                ngo.logoUrl,
                fit: BoxFit.contain, // Fit logo without stretching
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.business, size: 40, color: Colors.grey)), // Placeholder icon
              ),
            ),
            const SizedBox(height: 12),
            Text(
              ngo.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}