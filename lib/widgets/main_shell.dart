import 'package:flutter/material.dart';
import 'nav_drawer.dart';
import 'nav_rail.dart';

class MainShell extends StatefulWidget {
  final Widget child;
  final String currentRouteName;

  const MainShell({
    super.key,
    required this.child,
    required this.currentRouteName,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  double _currentDistance = 25.0;

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Configurações'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Raio de distância: ${_currentDistance.toStringAsFixed(1)} Km'),
                  Slider(
                    value: _currentDistance,
                    min: 5.0,
                    max: 50.0,
                    divisions: 18,
                    label: '${_currentDistance.toStringAsFixed(1)} Km',
                    onChanged: (value) {
                      setDialogState(() {
                        _currentDistance = value;
                      });
                    },
                    onChangeEnd: (value) {
                      setState(() {
                        _currentDistance = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Fechar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: _CustomAppBar(onSettingsTap: _showSettingsDialog),
      ),
      drawer: _isMobile(context)
          ? NavDrawer(currentRouteName: widget.currentRouteName)
          : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1200) {
            return Row(
              children: [
                NavRail(currentRouteName: widget.currentRouteName),
                const VerticalDivider(width: 1),
                Expanded(child: widget.child), // <-- Content goes here
                const VerticalDivider(width: 1),
                const SizedBox(width: 300, child: _RightSidebar()),
              ],
            );
          } else if (constraints.maxWidth > 800) {
            return Row(
              children: [
                NavRail(currentRouteName: widget.currentRouteName),
                const VerticalDivider(width: 1),
                Expanded(child: widget.child), // <-- Content goes here
              ],
            );
          } else {
            return widget.child; // <-- Content goes here
          }
        },
      ),
    );
  }

  bool _isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }
}

// All the private widgets from timeline_page are now here
class _CustomAppBar extends StatelessWidget {
  final VoidCallback onSettingsTap;
  const _CustomAppBar({required this.onSettingsTap});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;
    final theme = Theme.of(context);
    return AppBar(
      title: Text('petnet', style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
      centerTitle: isMobile,
      actions: [
        if (!isMobile)
          SizedBox(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Pesquisar no Petnet',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
        const SizedBox(width: 20),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Criar'),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.secondary,
            foregroundColor: theme.colorScheme.onSecondary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
        IconButton(onPressed: onSettingsTap, icon: const Icon(Icons.settings_outlined)),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(child: Icon(Icons.person)),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

class _RightSidebar extends StatelessWidget {
  const _RightSidebar();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text("Destaques", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        const Card(child: ListTile(title: Text("Vaquinha para a patinha quebrada"))),
        const Card(child: ListTile(title: Text("Precisamos de doações de rações"))),
        const SizedBox(height: 24),
        Text("Patrocinado", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        const Card(child: ListTile(title: Text("Ração fórmula natural Chef Bob"), subtitle: Text("R\$49,99"))),
        const SizedBox(height: 24),
        Text("Perto de mim", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        const Card(child: ListTile(title: Text("Contratação de Petsitter"), subtitle: Text("A 50m de você"))),
      ],
    );
  }
}