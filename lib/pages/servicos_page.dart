import 'package:flutter/material.dart';
import '../data/mock_database.dart'; // Import mock data
import '../widgets/service_search_card.dart'; // Import the new card widget

class ServicosPage extends StatefulWidget {
  const ServicosPage({super.key});

  @override
  State<ServicosPage> createState() => _ServicosPageState();
}

class _ServicosPageState extends State<ServicosPage> {
  final MockDatabaseService _dbService = MockDatabaseService();
  late Future<List<ServiceFilter>> _filtersFuture;
  final Set<String> _selectedFilters = {}; // Keep track of selected chips

  @override
  void initState() {
    super.initState();
    _filtersFuture = _dbService.getServiceFilters();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      children: [
        // --- Header ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Conheça os nossos serviços', style: textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(
                'Conte com nosso time de profissionais parceiros e encontre serviços de qualidade para o seu pet em poucos passos!',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // --- Filter Chips ---
        _buildFilterChips(), // Uses FutureBuilder internally

        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),

        // --- Available Services Section ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Serviços disponíveis', style: textTheme.titleMedium),
              SizedBox(
                width: 200, // Limit width
                height: 40, // Match chip height
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
            ],
          ),
        ),
        const SizedBox(height: 24),

        // --- Service Search Cards ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ServiceSearchCard(
            title: 'Encontre um Pet Shop perto de você!',
            imageUrl: 'https://images.unsplash.com/photo-1599443012599-2bf039587a69?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
            buttonColor: theme.colorScheme.primary, // Blue
            iconBackgroundColor: theme.colorScheme.primary, // Blue
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ServiceSearchCard(
            title: 'Encontre um Pet Sitter perto de você!',
            imageUrl: 'https://images.unsplash.com/photo-1543466835-00a7907e9de1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1074&q=80',
            buttonColor: theme.colorScheme.secondary, // Green
            iconBackgroundColor: theme.colorScheme.secondary, // Green
          ),
        ),
        const SizedBox(height: 24), // Add padding at the bottom
      ],
    );
  }

  // Helper widget to build the filter chips row with FutureBuilder
  Widget _buildFilterChips() {
    return FutureBuilder<List<ServiceFilter>>(
      future: _filtersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(height: 40); // Placeholder height
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink(); // Don't show anything if filters fail
        }

        final filters = snapshot.data!;
        final theme = Theme.of(context);

        return SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            itemCount: filters.length + 1, // +1 for the add button
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              if (index == filters.length) {
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
              final filter = filters[index];
              final isSelected = _selectedFilters.contains(filter.id);
              return FilterChip(
                label: Text(filter.name),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedFilters.add(filter.id);
                    } else {
                      _selectedFilters.remove(filter.id);
                    }
                  });
                },
                showCheckmark: false,
                side: BorderSide(color: isSelected ? Colors.transparent : Colors.grey.shade400),
                selectedColor: theme.colorScheme.primaryContainer.withOpacity(0.5),
              );
            },
          ),
        );
      },
    );
  }
}