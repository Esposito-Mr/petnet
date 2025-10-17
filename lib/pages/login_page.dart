import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart'; // Import the fake auth service
import '../widgets/image_panel.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 768) {
            return Center(child: _buildDesktopLayout());
          } else {
            return _buildMobileLayout(constraints);
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 650),
      margin: const EdgeInsets.all(24),
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        clipBehavior: Clip.antiAlias,
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 2, child: LoginForm(isMobile: false)),
            Expanded(flex: 3, child: ImagePanel()),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BoxConstraints constraints) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/pug_image.jpg', fit: BoxFit.cover),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF4C87B9).withOpacity(0.85),
                const Color(0xFF6EE087).withOpacity(0.85),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
              child: LoginForm(isMobile: true),
            ),
          ),
        ),
      ],
    );
  }
}

class LoginForm extends StatelessWidget {
  final bool isMobile;
  const LoginForm({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isMobile ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
      decoration: isMobile
          ? null
          : const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4C87B9), Color(0xFF6EE087)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/petnet_logo.jpeg', height: 32),
          const SizedBox(height: 40),
          const Text('Bem-vindo\nde volta', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold, height: 1.2)),
          const SizedBox(height: 10),
          const Text('Estamos felizes em te ver.', style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 40),
          TextField(
            decoration: InputDecoration(
              hintText: 'Email',
              prefixIcon: const Icon(Icons.email, color: Colors.black54),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Senha',
              prefixIcon: const Icon(Icons.lock, color: Colors.black54),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final authService = FakeAuthService();
                final bool isLoggedIn = await authService.fakeSignIn();

                // Check if the widget is still in the tree before navigating
                if (isLoggedIn && context.mounted) {
                  // Use pushReplacementNamed to go to the timeline and prevent the user
                  // from pressing the back button to return to the login screen.
                  Navigator.pushReplacementNamed(context, '/timeline');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4C87B9),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('ENTRAR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text.rich(
              TextSpan(
                text: 'Não tem uma conta? ',
                style: const TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    text: 'Crie uma',
                    style: const TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline, color: Colors.white),
                    recognizer: TapGestureRecognizer()..onTap = () => Navigator.pushNamed(context, '/signup'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}