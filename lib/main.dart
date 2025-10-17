import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/adocao_page.dart';
import 'providers/theme_provider.dart'; // Import Provider
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/timeline_page.dart';
import 'pages/marketplace_page.dart';
import 'pages/servicos_page.dart';
import 'pages/ongs_page.dart';
import 'widgets/main_shell.dart';

void main() {
  runApp(
    // IMPORTANT: Provide the ThemeProvider above MyApp
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primaryColor = Color(0xFF508CBB);
  static const Color accentColorPink = Color(0xFFEA5B6A);
  static const Color accentColorGreen = Color(0xFF60D67A);

  @override
  Widget build(BuildContext context) {
    // Access the ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Petnet App',
      debugShowCheckedModeBanner: false,
      // IMPORTANT: Use themeMode from the provider
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.light,
          secondary: accentColorGreen,
          // You might want specific colors for light theme here
        ),
        useMaterial3: true,
        // Add other light theme customizations if needed
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.dark,
          secondary: accentColorGreen,
          // Adjust dark theme specific colors if needed
          // background: Colors.black, // Example
          // surface: Colors.grey[850], // Example
        ),
        useMaterial3: true,
        // Add other dark theme customizations
      ),
      initialRoute: '/login', // Starts at login
      routes: {
        // Auth Routes (don't use MainShell)
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),

        // App Shell Routes
        '/timeline': (context) => const MainShell( currentRouteName: '/timeline', child: TimelinePage(), ),
        '/marketplace': (context) => const MainShell( currentRouteName: '/marketplace', child: MarketplacePage(), ),
        '/adocao': (context) => const MainShell( currentRouteName: '/adocao', child: AdocaoPage(), ),
        '/servicos': (context) => const MainShell( currentRouteName: '/servicos', child: ServicosPage(), ),
         '/ongs': (context) => const MainShell( currentRouteName: '/ongs', child: ONGsPage(), ),
        // Placeholders for other routes
        '/explorar': (context) => const MainShell(currentRouteName: '/explorar', child: Center(child: Text('Explorar Page'))),
        '/amigos': (context) => const MainShell(currentRouteName: '/amigos', child: Center(child: Text('Amigos Page'))),
        '/grupos': (context) => const MainShell(currentRouteName: '/grupos', child: Center(child: Text('Grupos Page'))),
        '/problema': (context) => const MainShell(currentRouteName: '/problema', child: Center(child: Text('Relatar Problema Page'))),
        '/atividade': (context) => const MainShell(currentRouteName: '/atividade', child: Center(child: Text('Sua Atividade Page'))),
      },
    );
  }
}