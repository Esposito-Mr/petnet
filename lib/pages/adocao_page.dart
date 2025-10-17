import 'package:flutter/material.dart';
import '../data/mock_database.dart';
import '../models/pet_model.dart';
import '../widgets/pet_card.dart';

class AdocaoPage extends StatefulWidget {
  const AdocaoPage({super.key});

  @override
  State<AdocaoPage> createState() => _AdocaoPageState();
}

class _AdocaoPageState extends State<AdocaoPage> {
  final MockDatabaseService _dbService = MockDatabaseService();
  late Future<List<Pet>> _petsFuture;

  @override
  void initState() {
    super.initState();
    _petsFuture = _dbService.getAdoptablePets();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pet>>(
      future: _petsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar pets.'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum pet encontrado.'));
        }

        final pets = snapshot.data!;

        // We use a CustomScrollView to easily mix lists and other widgets
        return CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Campanha de adoção',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Uma seleção especial de peludinhos que buscam um lar para chamar de seu. '
                      'Não encontrou seu pet aqui ainda? Preencha o formulário de intenção '
                      'que uma ONG parceira entrará em contato com você.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            // Filter bar
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pets disponíveis',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.filter_list, size: 20),
                          label: const Text('Filtrar'),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border, size: 20),
                          label: const Text('Meus favoritos'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Pets Grid
            SliverPadding(
              padding: const EdgeInsets.all(24.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 350.0, // Max width for each card
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 0.75, // Aspect ratio (width / height)
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return PetCard(pet: pets[index]);
                  },
                  childCount: pets.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}