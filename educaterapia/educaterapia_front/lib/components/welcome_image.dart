import 'package:flutter/material.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/imagens/menina.jpeg',
      height: 350,
    );
  }
}
