import 'package:flutter/material.dart';

class ServiceSearchCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Color buttonColor;
  final Color iconBackgroundColor;

  const ServiceSearchCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.buttonColor,
    required this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return LayoutBuilder(builder: (context, constraints) {
      bool isMobile = constraints.maxWidth < 600;

      final content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 20),
          _buildSearchField(context, Icons.location_on_outlined, 'Localização', 'qualquer lugar', iconBackgroundColor),
          const SizedBox(height: 16),
          _buildSearchField(context, Icons.paid_outlined, 'Faixa de preço', 'qualquer preço', iconBackgroundColor),
          const SizedBox(height: 16),
          _buildSearchField(context, Icons.home_repair_service_outlined, 'Tipo de serviço', 'qualquer serviço', iconBackgroundColor),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: buttonColor,
              side: BorderSide(color: buttonColor),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            ),
            child: const Text('Buscar'),
          ),
        ],
      );

      final image = ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          height: isMobile ? 250 : 350,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) => Container(
            height: isMobile ? 250 : 350,
            color: Colors.grey.shade300,
            child: const Center(child: Icon(Icons.image_not_supported)),
          ),
        ),
      );

      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        elevation: 2.0, // Subtle elevation
        child: isMobile
            ? Column(children: [image, Padding(padding: const EdgeInsets.all(20), child: content)])
            : Row(
                children: [
                  Expanded(flex: 2, child: Padding(padding: const EdgeInsets.all(24), child: content)),
                  Expanded(flex: 3, child: image),
                ],
              ),
      );
    });
  }

  Widget _buildSearchField(BuildContext context, IconData icon, String label, String hint, Color iconBgColor) {
    final theme = Theme.of(context);
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: iconBgColor.withOpacity(0.2),
          child: Icon(icon, color: iconBgColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
              Text(hint, style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor)),
            ],
          ),
        ),
        Icon(Icons.arrow_drop_down, color: theme.hintColor),
      ],
    );
  }
}