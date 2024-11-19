import 'package:flutter/material.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://example.com/image.png', // Substitua pela URL da sua imagem
      height: 250,
    );
  }
}
