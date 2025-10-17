import 'package:flutter/material.dart';
import '../data/mock_database.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../widgets/category_circle.dart';
import '../widgets/product_card.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  final MockDatabaseService _dbService = MockDatabaseService();
  late Future<List<Product>> _productsFuture;
  late Future<List<Category>> _dogCategoriesFuture;
  late Future<List<Category>> _catCategoriesFuture;

  // State for selected filter chips
  final List<String> _filters = [
    'Banho e tosa', 'Rações e petiscos', 'Acessórios e roupas',
    'Coleiras e guias', 'Medicamentos e suplementos'
  ];
  final Set<String> _selectedFilters = {};

  @override
  void initState() {
    super.initState();
    // Load all data when the page starts
    _productsFuture = _dbService.getRecommendedProducts();
    _dogCategoriesFuture = _dbService.getDogCategories();
    _catCategoriesFuture = _dbService.getCatCategories();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 24.0), // Padding top/bottom
      children: [
        // --- Essential Care Section ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Cuidados essenciais', style: textTheme.headlineSmall),
              SizedBox(
                width: 200, // Limit width of the search bar
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'palavra-chave',
                    suffixIcon: const Icon(Icons.search, size: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart_outlined, size: 20),
                label: const Text('Meu carrinho'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Filter Chips
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            itemCount: _filters.length + 1, // +1 for the add button
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              if (index == _filters.length) {
                // Last item is the "+" button
                return IconButton.outlined(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  style: IconButton.styleFrom(
                    side: BorderSide(color: theme.colorScheme.primary),
                    foregroundColor: theme.colorScheme.primary,
                  ),
                );
              }
              final filter = _filters[index];
              final isSelected = _selectedFilters.contains(filter);
              return FilterChip(
                label: Text(filter),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedFilters.add(filter);
                    } else {
                      _selectedFilters.remove(filter);
                    }
                  });
                },
                showCheckmark: false,
                side: BorderSide(color: isSelected ? Colors.transparent : Colors.grey.shade400),
              );
            },
          ),
        ),
        const SizedBox(height: 32),

        // --- Recommended Products Section ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text('Produtos recomendados', style: textTheme.headlineSmall),
        ),
        const SizedBox(height: 16),
        _buildProductGrid(), // Uses FutureBuilder internally
        const SizedBox(height: 32),

        // --- Dog Categories Section ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text('Tudo para cachorros', style: textTheme.headlineSmall),
        ),
        const SizedBox(height: 16),
        _buildCategoryRow(_dogCategoriesFuture), // Uses FutureBuilder internally
        const SizedBox(height: 32),

        // --- Cat Categories Section ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text('Tudo para gatos', style: textTheme.headlineSmall),
        ),
        const SizedBox(height: 16),
        _buildCategoryRow(_catCategoriesFuture), // Uses FutureBuilder internally
      ],
    );
  }

  // Helper widget to build the product grid with FutureBuilder
  Widget _buildProductGrid() {
    return FutureBuilder<List<Product>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum produto encontrado.'));
        }
        final products = snapshot.data!;
        return GridView.builder(
          shrinkWrap: true, // Important inside a ListView
          physics: const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250, // Max width for each product card
            childAspectRatio: 0.7,   // Adjust aspect ratio if needed
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) => ProductCard(product: products[index]),
        );
      },
    );
  }

  // Helper widget to build the category rows with FutureBuilder
  Widget _buildCategoryRow(Future<List<Category>> future) {
    return FutureBuilder<List<Category>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(height: 120, child: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox(height: 120, child: Center(child: Text('Categorias não encontradas.')));
        }
        final categories = snapshot.data!;
        return SizedBox(
          height: 120, // Fixed height for the horizontal list
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            itemCount: categories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) => CategoryCircle(category: categories[index]),
          ),
        );
      },
    );
  }
}