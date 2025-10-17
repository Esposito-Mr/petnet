import 'package:flutter/material.dart';
import '../data/mock_database.dart';
import '../models/ngo_model.dart';
import '../widgets/ngo_card.dart';

class ONGsPage extends StatefulWidget {
  const ONGsPage({super.key});

  @override
  State<ONGsPage> createState() => _ONGsPageState();
}

class _ONGsPageState extends State<ONGsPage> {
  final MockDatabaseService _dbService = MockDatabaseService();
  late Future<List<NGO>> _ngosFuture;

  // State for filter buttons
  final List<String> _filters = ['Faça uma doação', 'Parceiros', 'Vaquinhas', 'Apadrinhe'];
  final Set<String> _selectedFilters = {}; // Could be used to filter NGO list later

  @override
  void initState() {
    super.initState();
    _ngosFuture = _dbService.getNGOsSortedByActivity();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return FutureBuilder<List<NGO>>(
      future: _ngosFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar ONGs.'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhuma ONG encontrada.'));
        }

        final ngos = snapshot.data!;

        return CustomScrollView(
          slivers: [
            // --- Header ---
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ONGs e Protetores', style: textTheme.headlineMedium),
                    const SizedBox(height: 8),
                    Text(
                      'Que tal uma estender uma patinha amiga? Se você for uma ONG ou Protetor interessado em fazer parte dos nossos espaços dedicados à adoção, saiba mais sobre o processo de cadastramento abaixo.',
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    // Filter Action Buttons
                    Wrap( // Use Wrap for responsiveness
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        ..._filters.map((filter) {
                          final isSelected = _selectedFilters.contains(filter);
                          return FilterChip(
                            label: Text(filter),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) { _selectedFilters.add(filter); }
                                else { _selectedFilters.remove(filter); }
                              });
                            },
                            avatar: isSelected ? null : const Icon(Icons.add_circle_outline, size: 18),
                            showCheckmark: false,
                            backgroundColor: isSelected ? theme.colorScheme.secondaryContainer : null,
                            selectedColor: theme.colorScheme.secondaryContainer,
                            side: BorderSide(color: isSelected ? Colors.transparent : Colors.grey.shade400),
                            labelStyle: TextStyle(color: isSelected ? theme.colorScheme.onSecondaryContainer : null),
                          );
                        }).toList(),
                         // Add button
                         ActionChip(
                           label: const Icon(Icons.add, size: 18),
                           onPressed: (){},
                           side: BorderSide(color: Colors.grey.shade400),
                           padding: const EdgeInsets.all(8),
                         ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: Divider(height: 32)),

            // --- ONG List Header ---
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Conheça as ONGs', style: textTheme.titleMedium),
                    Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.filter_list, size: 20),
                          label: const Text('Filtrar'),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 200,
                          height: 40,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Nome da ONG',
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
                    )
                  ],
                ),
              ),
            ),

            // --- ONG Grid ---
            SliverPadding(
              padding: const EdgeInsets.all(24.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Fixed 3 columns as per design
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 1.0, // Make cards roughly square
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return NGOCard(ngo: ngos[index]);
                  },
                  childCount: ngos.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}