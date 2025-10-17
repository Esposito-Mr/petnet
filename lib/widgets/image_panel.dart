import 'package:flutter/material.dart';

class ImagePanel extends StatelessWidget {
  const ImagePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/pug_image.jpg', fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Icon(Icons.image_not_supported, color: Colors.black26, size: 50));
          },
        ),
        Container(color: Colors.black.withOpacity(0.1)),
        Positioned(
          top: 40, left: 40,
          child: RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, fontFamily: 'Roboto', color: Colors.white, shadows: [Shadow(blurRadius: 10.0, color: Colors.black45, offset: Offset(2.0, 2.0))]),
              children: <TextSpan>[
                TextSpan(text: 'Interagir.\n', style: TextStyle(color: Color(0xFF64C5EF))),
                TextSpan(text: 'Cuidar.\n', style: TextStyle(color: Color(0xFF53A557))),
                TextSpan(text: 'Adotar.', style: TextStyle(color: Color(0xFF2C5E9A))),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20, right: 20,
          child: Padding(padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/paw_heart.jpeg', width: 32, height: 32),
          ),
        ),
      ],
    );
  }
}