import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class NavContent extends StatelessWidget {
  final String currentRouteName;
  const NavContent({super.key, required this.currentRouteName});

  @override
  Widget build(BuildContext context) {
    // Access the provider but DON'T listen here if only calling methods
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    // Listen for theme changes specifically for the Switch state
    // Use watch or select if you only need specific properties
    final isDarkMode = context.watch<ThemeProvider>().themeMode == ThemeMode.dark;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildNavItem( context, Icons.home_outlined, 'Página Inicial', routeName: '/timeline', currentRoute: currentRouteName, ),
        _buildNavItem( context, Icons.business_outlined, 'ONGs', routeName: '/ongs', currentRoute: currentRouteName, ),
        _buildNavItem( context, Icons.favorite_border, 'Adoção', routeName: '/adocao', currentRoute: currentRouteName, ),
        _buildNavItem( context, Icons.store_outlined, 'Serviços', routeName: '/servicos', currentRoute: currentRouteName, ),
        _buildNavItem( context, Icons.shopping_bag_outlined, 'Marketplace', routeName: '/marketplace', currentRoute: currentRouteName, ),
        const Divider(height: 30),
        const Text('Comunidade', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _buildNavItem( context, Icons.explore_outlined, 'Explorar', routeName: '/explorar', currentRoute: currentRouteName, ),
        _buildNavItem( context, Icons.people_outline, 'Amigos', routeName: '/amigos', currentRoute: currentRouteName, ),
        _buildNavItem( context, Icons.group_outlined, 'Grupos', routeName: '/grupos', currentRoute: currentRouteName, ),
        const Divider(height: 30),
        const Text('Conta', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _buildNavItem( context, Icons.report_problem_outlined, 'Relatar problema', routeName: '/problema', currentRoute: currentRouteName, ),
        _buildNavItem( context, Icons.history, 'Sua atividade', routeName: '/atividade', currentRoute: currentRouteName, ),

        // Theme Switch
        SwitchListTile(
          contentPadding: const EdgeInsets.only(left: 16, right: 8),
          title: const Text('Modo de exibição'),
          value: isDarkMode,
          onChanged: (value) {
            // Call the provider's method to change the theme
            themeProvider.setTheme(value ? ThemeMode.dark : ThemeMode.light);
          },
          secondary: Icon(isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
        ),
      ],
    );
  }

  // --- Helper Method for Navigation Items ---
  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String title, {
    required String routeName,
    required String currentRoute,
  }) {
    final isSelected = (routeName == currentRoute);
    final colorScheme = Theme.of(context).colorScheme;
    final isMobile = MediaQuery.of(context).size.width < 800;

    return ListTile(
      leading: Icon(icon, color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? colorScheme.primary : colorScheme.onSurface,
        ),
      ),
      onTap: () {
        // If already selected and on mobile, just close the drawer
        if (isSelected && isMobile) {
          Navigator.pop(context);
          return;
        }
        // If already selected and not mobile, do nothing
        if (isSelected && !isMobile) {
          return;
        }

        // Use pushReplacementNamed to navigate without building up the stack
        Navigator.pushReplacementNamed(context, routeName);
      },
      selected: isSelected,
      selectedTileColor: colorScheme.primary.withOpacity(0.1), // Subtle background for selected item
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}