import 'package:flutter/material.dart';
import '../components/welcome_image.dart';
import '../components/welcome_text.dart';
import '../components/custom_button.dart';
import 'premium_screen.dart'; // Importando a PremiumScreen

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const WelcomeImage(),
            const SizedBox(height: 20),
            const WelcomeText(),
            const SizedBox(height: 20),
            CustomButton(
              text: "Saiba Mais",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PremiumScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
