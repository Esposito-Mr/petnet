import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For currency formatting
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Currency formatter
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
               color: Colors.grey.shade200, // Background for the image
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.contain, // Use contain to show the whole product
                width: double.infinity,
                // Add error builder for robustness
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.error_outline)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(product.brand, style: theme.textTheme.bodySmall),
                const SizedBox(height: 8),
                Text(
                  formatCurrency.format(product.price),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}