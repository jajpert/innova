import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16.0), // Espaço nas laterais da tela
      child: SizedBox(
        width: double.infinity, // Ocupa a largura total da tela
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                const Color(0xFF5D72F6), // Cor personalizada #5D72F6
            padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 24.0), // Ajuste de espaçamento interno
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Texto à esquerda e ícone à direita
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 18, // Ajuste do tamanho do ícone
              ),
            ],
          ),
        ),
      ),
    );
  }
}
